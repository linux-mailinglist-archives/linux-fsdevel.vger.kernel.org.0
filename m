Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 897F81BB43E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 04:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgD1C5L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 22:57:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:56286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726047AbgD1C5L (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 22:57:11 -0400
Received: from gmail.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5F24206D9;
        Tue, 28 Apr 2020 02:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588042630;
        bh=KMoWDxpGaQr/ln9Z9giAt4S1WNAg+DpDSQwhL7afMGw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2HrjeEFFlHfnzWjDm4ColnMepl8ZopK0YduhMIHGDhjZBrXGApO+wnttWu8/QuQo+
         CTXWoRtXSoS1ldbMpr0jsCeFYmwzz+HeCHwxOztKrmTRPMyj3UvzMLUZh+jOVv3do0
         ItTzveDfp7GGp/chLacrxyZWjSu0k+hxG8k1HuEI=
Date:   Mon, 27 Apr 2020 19:57:08 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v10 02/12] block: Keyslot Manager for Inline Encryption
Message-ID: <20200428025708.GB251491@gmail.com>
References: <20200408035654.247908-1-satyat@google.com>
 <20200408035654.247908-3-satyat@google.com>
 <20200422092250.GA12290@infradead.org>
 <20200428021441.GA52406@google.com>
 <20200428024614.GA251491@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428024614.GA251491@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 27, 2020 at 07:46:14PM -0700, Eric Biggers wrote:
> On Tue, Apr 28, 2020 at 02:14:41AM +0000, Satya Tangirala wrote:
> > > > +int blk_ksm_evict_key(struct blk_keyslot_manager *ksm,
> > > > +		      const struct blk_crypto_key *key)
> > > > +{
> > > > +	struct blk_ksm_keyslot *slot;
> > > > +	int err = 0;
> > > > +
> > > > +	blk_ksm_hw_enter(ksm);
> > > > +	slot = blk_ksm_find_keyslot(ksm, key);
> > > > +	if (!slot)
> > > > +		goto out_unlock;
> > > > +
> > > > +	if (atomic_read(&slot->slot_refs) != 0) {
> > > > +		err = -EBUSY;
> > > > +		goto out_unlock;
> > > > +	}
> > > 
> > > This check looks racy.
> > Yes, this could in theory race with blk_ksm_put_slot (e.g. if it's
> > called while there's still IO in flight/IO that just finished) - But
> > it's currently only called by fscrypt when a key is being destroyed,
> > which only happens after all the inodes using that key are evicted, and
> > no data is in flight, so when this function is called, slot->slot_refs
> > will be 0. In particular, this function should only be called when the
> > key isn't being used for IO anymore. I'll add a WARN_ON_ONCE and also
> > make the assumption clearer. We could also instead make this wait for
> > the slot_refs to become 0 and then evict the key instead of just
> > returning -EBUSY as it does now, but I'm not sure if it's really what
> > we want to do/worth doing right now...
> 
> Note that we're holding down_write(&ksm->lock) here, which synchronizes with
> someone getting the keyslot (in particular, incrementing its refcount from 0)
> because that uses down_read(&ksm->lock).
> 
> So I don't think there's a race.  The behavior is just that if someone tries to
> evict a key that's still in-use, then we'll correctly fail to evict the key.
> 
> "Evicting a key that's still in-use" isn't supposed to happen, so printing a
> warning is a good idea.  But I think it needs to be pr_warn_once(), not
> WARN_ON_ONCE(), because WARN_ON_ONCE() is for kernel bugs only, not userspace
> bugs.  It's theoretically possible for userspace to cause the same key to be
> used multiple times on the same disk but via different blk_crypto_key's.  The
> keyslot manager will put these in the same keyslot, but there will be a separate
> eviction attempt for each blk_crypto_key.
> 
> For example, with fscrypt with -o inlinecrypt and blk-crypto-fallback, userspace
> could create an encrypted file using FSCRYPT_MODE_ADIANTUM and flags == 0, then
> get its encryption nonce and derive the file's encryption key.  Then in another
> directory, they could set FSCRYPT_MODE_ADIANTUM and flags ==
> FSCRYPT_POLICY_FLAG_DIRECT_KEY, and use the other file's encryption key as the
> *master* key.
> 
> That would be totally insane for userspace to do.  But it's possible, so we
> can't use WARN_ON_ONCE().
> 

Or maybe 'struct blk_ksm_keyslot' should contain a pointer to the
'struct blk_crypto_key' rather than a copy of it?  If we did that, then:

- Each duplicate blk_crypto_key would use its own keyslot and not interfere with
  any others.

- blk_crypto_evict_key() would be *required* to be called.

- It would be a kernel bug if blk_crypto_evict_key() were called with any
  pending I/O, so WARN_ON_ONCE() would be the right thing to do.

- The hash function used to find a key's keyslot would be
  hash_ptr(blk_crypto_key, ksm->log_slot_hashtable_size) instead of
  SipHash(key=perboot_key, data=raw_key).
  
I might be forgetting something; was there a reason we didn't do that?
It wouldn't be as robust against users forgetting to call
blk_crypto_evict_key(), but that would be a bug anyway.

- Eric
