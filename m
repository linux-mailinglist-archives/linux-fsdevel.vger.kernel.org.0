Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5FE11E353E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 May 2020 04:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbgE0CLP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 May 2020 22:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbgE0CLP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 May 2020 22:11:15 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6105C03E97B
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 May 2020 19:11:14 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id u188so1524361wmu.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 May 2020 19:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ipUdTLnpQOIojrMyR3JyiZnfjmcjJ5S3+vvLX0u1WTg=;
        b=DOuH2kP2aeGP1W4uOzhBKrSoSzufsBnclYFQQFHRS9g2gBz9ORHxXyrcJmDgHCI+nd
         lKZR3CxT8/SFUPl/0RSlQZoTAvQ2VoBGw5IJ03AscxowpPHOX45qQPtC3m1xh2vs5nBb
         StR23Z28+tzSznWdX5y5wF+aiDvT1LQNmvQB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ipUdTLnpQOIojrMyR3JyiZnfjmcjJ5S3+vvLX0u1WTg=;
        b=MonCVDjLe/ECghjBlA4B600c0jkSoO3YwnkJqkz8dMNPnVx7BiJmg16HqVA46wMJc5
         fbCAgeyaHmG0babBuH7Bpe8xWxWnM5+vZjpr+QWEYyrMmD7wcZxovJN5ZEBN/xjl+YnB
         HkzCUILvnqLscuS8g4sS0vuBWvMsgzVQ0ow9XdsGjp/CGBL/0dGUKz45iLOOtshKRMog
         YjRdJECWr2NCXI39enso2oFcKZAM3uf6bmvBmGYFH59yoJggfhGbLoP4kjbvHNrhQ0qu
         PEfHGxwdjqOpOXMcxdivE/x258ehGOfqwoMjLXm+oUMeUpc6IQs6iKqa7uUFG+45PoBM
         1Gpg==
X-Gm-Message-State: AOAM530DAfdY9zgrzXpVZPL0vBdTaovSvVJjIHP15ZFSVBvozZEuFIXd
        tJUOnUf6ETEksFItlu35/BOJ1w==
X-Google-Smtp-Source: ABdhPJw2LdNhciHKkSNxeAMGIla1TaBk20r0eRoecZGPQSy8eengZqskOy+JhG0pZfQ9RCfwACNT2w==
X-Received: by 2002:a1c:117:: with SMTP id 23mr1993725wmb.90.1590545473423;
        Tue, 26 May 2020 19:11:13 -0700 (PDT)
Received: from google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id l19sm1259285wmj.14.2020.05.26.19.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 19:11:12 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Wed, 27 May 2020 04:11:11 +0200
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     KP Singh <kpsingh@chromium.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Martin KaFai Lau <kafai@fb.com>,
        Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>
Subject: Re: [PATCH bpf-next 2/4] bpf: Implement bpf_local_storage for inodes
Message-ID: <20200527021111.GA197666@google.com>
References: <20200526163336.63653-1-kpsingh@chromium.org>
 <20200526163336.63653-3-kpsingh@chromium.org>
 <20200527004902.lo6c2efv5vix5nqq@ast-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527004902.lo6c2efv5vix5nqq@ast-mbp.dhcp.thefacebook.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thanks for taking a look!

On 26-May 17:49, Alexei Starovoitov wrote:
> On Tue, May 26, 2020 at 06:33:34PM +0200, KP Singh wrote:
> >  
> > +static struct bpf_local_storage_data *inode_storage_update(
> > +	struct inode *inode, struct bpf_map *map, void *value, u64 map_flags)
> > +{
> > +	struct bpf_local_storage_data *old_sdata = NULL;
> > +	struct bpf_local_storage_elem *selem;
> > +	struct bpf_local_storage *local_storage;
> > +	struct bpf_local_storage_map *smap;
> > +	int err;
> > +
> > +	err = check_update_flags(map, map_flags);
> > +	if (err)
> > +		return ERR_PTR(err);
> > +
> > +	smap = (struct bpf_local_storage_map *)map;
> > +	local_storage = rcu_dereference(inode->inode_bpf_storage);
> > +
> > +	if (!local_storage || hlist_empty(&local_storage->list)) {
> > +		/* Very first elem for this inode */
> > +		err = check_flags(NULL, map_flags);
> > +		if (err)
> > +			return ERR_PTR(err);
> > +
> > +		selem = selem_alloc(smap, value);
> > +		if (!selem)
> > +			return ERR_PTR(-ENOMEM);
> > +
> > +		err = inode_storage_alloc(inode, smap, selem);
> 
> inode_storage_update looks like big copy-paste except above one line.
> pls consolidate.

Sure.

> 
> > +BPF_CALL_4(bpf_inode_storage_get, struct bpf_map *, map, struct inode *, inode,
> > +	   void *, value, u64, flags)
> > +{
> > +	struct bpf_local_storage_data *sdata;
> > +
> > +	if (flags > BPF_LOCAL_STORAGE_GET_F_CREATE)
> > +		return (unsigned long)NULL;
> > +
> > +	sdata = inode_storage_lookup(inode, map, true);
> > +	if (sdata)
> > +		return (unsigned long)sdata->data;
> > +
> > +	if (flags == BPF_LOCAL_STORAGE_GET_F_CREATE &&
> > +	    atomic_inc_not_zero(&inode->i_count)) {
> > +		sdata = inode_storage_update(inode, map, value, BPF_NOEXIST);
> > +		iput(inode);
> > +		return IS_ERR(sdata) ?
> > +			(unsigned long)NULL : (unsigned long)sdata->data;
> > +	}
> 
> This is wrong. You cannot just copy paste the refcounting logic
> from bpf_sk_storage_get(). sk->sk_refcnt is very different from inode->i_count.
> To start, the inode->i_count cannot be incremented without lock.

Good catch! Agreed, Jann pointed out that this can lead to bugs
similar to https://crbug.com/project-zero/2015.

> If you really need to do it you need igrab().
> Secondly, the iput() is not possible to call from bpf prog yet, since

> progs are not sleepable and iput() may call iput_final() which may sleep.

Agreed, I will send a separate patch to add a might_sleep call to
iput() which currently only has a "Consequently, iput() can sleep."
warning in the comments so that this can be caught by
CONFIG_DEBUG_ATOMIC_SLEEP.

> But considering that only lsm progs from lsm hooks will call bpf_inode_storage_get()
> the inode is not going to disappear while this function is running.

If the inode pointer is an argument to the LSM hook, it won't
disappear and yes this does hold generally true for the other
use-cases as well.

> So why touch i_count ?
> 
> > +
> > +	return (unsigned long)NULL;
> > +}
> > +
> >  BPF_CALL_2(bpf_sk_storage_delete, struct bpf_map *, map, struct sock *, sk)
> >  {
> >  	if (refcount_inc_not_zero(&sk->sk_refcnt)) {
> > @@ -957,6 +1229,20 @@ BPF_CALL_2(bpf_sk_storage_delete, struct bpf_map *, map, struct sock *, sk)
> >  	return -ENOENT;
> >  }
> >  
> > +BPF_CALL_2(bpf_inode_storage_delete,
> > +	   struct bpf_map *, map, struct inode *, inode)
> > +{
> > +	int err;
> > +
> > +	if (atomic_inc_not_zero(&inode->i_count)) {
> > +		err = inode_storage_delete(inode, map);
> > +		iput(inode);
> > +		return err;
> > +	}
> 
> ditto.
> 
> > +
> > +	return inode_storage_delete(inode, map);
> 
> bad copy-paste from bpf_sk_storage_delete?
> or what is this logic suppose to do?

The former :) fixed...

- KP
