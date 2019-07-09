Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1212D63E2F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2019 01:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfGIXAd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jul 2019 19:00:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:40402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726284AbfGIXAc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jul 2019 19:00:32 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A1F720693;
        Tue,  9 Jul 2019 23:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562713231;
        bh=mqZhnQlsfaKKtYTzAc3OH9DchjWPLQmojcR0X/Nieqw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vzXUz2HIFKteVEHxqti9rKG3oLGZG2C694w3R4hypaFOd0SA9dbT32K+xTO1i2Dh8
         3nluBJ2isuTx2QR8wY5M52xwivDW/IP6fpTNGDAactYWvX4Pd/XRDyt4WT909VmEBB
         eB+Pw1bv/Q7NxX+QXpDoscKHvxGzJdwHqU2Fkowk=
Date:   Tue, 9 Jul 2019 16:00:29 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     David Howells <dhowells@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfs: fsmount: add missing mntget()
Message-ID: <20190709230029.GO641@sol.localdomain>
Mail-Followup-To: Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
References: <20190610183031.GE63833@gmail.com>
 <20190612184313.143456-1-ebiggers@kernel.org>
 <20190613084728.GA32129@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613084728.GA32129@miu.piliscsaba.redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 13, 2019 at 10:47:28AM +0200, Miklos Szeredi wrote:
> On Wed, Jun 12, 2019 at 11:43:13AM -0700, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > sys_fsmount() needs to take a reference to the new mount when adding it
> > to the anonymous mount namespace.  Otherwise the filesystem can be
> > unmounted while it's still in use, as found by syzkaller.
> 
> So it needs one count for the file (which dentry_open() obtains) and one for the
> attachment into the anonymous namespace.  The latter one is dropped at cleanup
> time, so your patch appears to be correct at getting that ref.
> 
> I wonder why such a blatant use-after-free was missed in normal testing.  RCU
> delayed freeing, I guess?
> 
> How about this additional sanity checking patch?
> 
> Thanks,
> Miklos
> 
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index b26778bdc236..c638f220805a 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -153,10 +153,10 @@ static inline void mnt_add_count(struct mount *mnt, int n)
>  /*
>   * vfsmount lock must be held for write
>   */
> -unsigned int mnt_get_count(struct mount *mnt)
> +int mnt_get_count(struct mount *mnt)
>  {
>  #ifdef CONFIG_SMP
> -	unsigned int count = 0;
> +	int count = 0;
>  	int cpu;
>  
>  	for_each_possible_cpu(cpu) {
> @@ -1140,6 +1140,8 @@ static DECLARE_DELAYED_WORK(delayed_mntput_work, delayed_mntput);
>  
>  static void mntput_no_expire(struct mount *mnt)
>  {
> +	int count;
> +
>  	rcu_read_lock();
>  	if (likely(READ_ONCE(mnt->mnt_ns))) {
>  		/*
> @@ -1162,11 +1164,13 @@ static void mntput_no_expire(struct mount *mnt)
>  	 */
>  	smp_mb();
>  	mnt_add_count(mnt, -1);
> -	if (mnt_get_count(mnt)) {
> +	count = mnt_get_count(mnt);
> +	if (count > 0) {
>  		rcu_read_unlock();
>  		unlock_mount_hash();
>  		return;
>  	}
> +	WARN_ON(count < 0);
>  	if (unlikely(mnt->mnt.mnt_flags & MNT_DOOMED)) {
>  		rcu_read_unlock();
>  		unlock_mount_hash();
> diff --git a/fs/pnode.h b/fs/pnode.h
> index 49a058c73e4c..26f74e092bd9 100644
> --- a/fs/pnode.h
> +++ b/fs/pnode.h
> @@ -44,7 +44,7 @@ int propagate_mount_busy(struct mount *, int);
>  void propagate_mount_unlock(struct mount *);
>  void mnt_release_group_id(struct mount *);
>  int get_dominating_id(struct mount *mnt, const struct path *root);
> -unsigned int mnt_get_count(struct mount *mnt);
> +int mnt_get_count(struct mount *mnt);
>  void mnt_set_mountpoint(struct mount *, struct mountpoint *,
>  			struct mount *);
>  void mnt_change_mountpoint(struct mount *parent, struct mountpoint *mp,

Miklos, are you planning to send this as a formal patch?

- Eric
