Return-Path: <linux-fsdevel+bounces-59133-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9641FB34AF4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 21:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 271211A85B18
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 19:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE94284B5B;
	Mon, 25 Aug 2025 19:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="ouM+Sjx8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E41169AE6
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 19:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756150507; cv=none; b=usBFFZNqutGEDNosd94ijIAWUEb1EbiLptoSSgKS0b3wOZpVgwqf7MnQ8IDUExFDEsOMj50tQLvz06jOrt3h+nxvGPoLMzXQVqQ+1j3huSFHQ3LP3gdRz96ihJ7ma6ixJz6zCoY7xHrEs4hK4UKXT2s+kPaLSR0kBDBUTJ+uOVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756150507; c=relaxed/simple;
	bh=oezHH2OV9IQAQTvmhi0PGkJGTakD8P6Kca8eDrWjLaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L+O6OLqPy9rOUYfbRp+s2pF+8bG4HFxlDie9PHnMJtNXD6Lnp8aRTI5710NCfqK+EOanL1dTT1i2wKoBeVdP+nFl2gc9CWjDIE/hSWebzrijxOvE04HdtAIJdnAYsJhTd6QBu3Xskjv7m7I9vX982DFAm6ROIDh3gTcSE1HgF3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=ouM+Sjx8; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-71d60504db9so36626477b3.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 12:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756150505; x=1756755305; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wYuLPKGcVdOQFox0yjz3XsNMcHe6CSns2VOTsCthOLA=;
        b=ouM+Sjx8atQGgmj2FimpaoUdomTlALAZka266IV6mj3TaqOcCow8jyOp+dcRRd4EkT
         RgAgZI0lX0wXbstYYt29tyJNeT3KJaAj+s1wMbw3TJvqzkGjX7/qE4lcyB+IdGmziZPa
         whjKTplbsKkCXGNIbX/NyvMOHso406xqfdf45lEz2IPyhKPnKN5klGtJQ7k31aRheFdO
         zuNh/df6hj2eqgNQh5y4pJssR7fo/vQn6Iu5ncKRTOsMs2ILDkjh4dYWsiAMJPENB8ev
         jHfwv9mOXuGHxscgSLSQaMVgmd9pJ65ls3EMqElVwoqUPIitBryejqcna3FuQrC2DVID
         pb8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756150505; x=1756755305;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wYuLPKGcVdOQFox0yjz3XsNMcHe6CSns2VOTsCthOLA=;
        b=Ch0gZFbtfQF6/JZx5sOpHl1fqwGHod6rYarslw7umsNfF+raDTXDEW3JwpHf5U0/lY
         shQ3KEzf0Qvse0/Gxm1aAYmF+4q4YWbsVKasmRCzZwTVPSfGW+eLP42fmq3wMl9KYwho
         PeubGLpGSnzpOx2SLDLdZEY5EWnjwTVCTiDQug3kfZB5/WVnkGrxmV7hYoao0odv68Cr
         LrjJns9OU0tBURm7YDxVi5i549fnupYLTjC8CRJS3Eq1cxEssBua9OmjyBe5LAcdP4tO
         gwUQKW2dJ/dHKB+uwGcW3bCvG744wC3KrAnlksgL48wO+jlr8bhAzX68LotZSFLX7kPx
         l3fw==
X-Gm-Message-State: AOJu0Yyqf4VsUtnNQ/VKDsfXOX3IJrevBp6L8gnG2OTWN2jyy9C0MUYC
	pJEjb68a8t9nUakRhlIK6IyOuBV8gZW4GROITLGI/Rvz2WuF9BfOVzV9P1oQJSf1c70=
X-Gm-Gg: ASbGncuwq00coGprkgTcyU9rmUOqv3Ah8hS8VLleI/IYkUhoR71tycXHD3ZmV8isM96
	B0hkwGmBWi8TQH0zEPBPsRr3Z2l/ff/PrAccjikaZhciXj0+i7gwKNxrdCA6T33RC0FWPeMtNPR
	aQikU8ClPqtlkDAGXuJ6yQfUlJdec+5W6TOtDmu6ukRLTnKjRZlsSdNHeyJT/rkGCXjkunuX+Bq
	xQscgRoXxMLt97MjnBvUXMHBdJXfQeEOYKogNbmb06WEJbOo0w5DWN+OYjK0bb121u/GkmlBWim
	ETeOaugOHX2VRBJVwR2BuPPbZEandzrDzjEG2fcHvpiR5sJikIKghMMNve/AddXzxckZ0CmdrfO
	igEfFF8gUAi6Xx+DjbsECLWHLYSUEktIvWaVh4JHiPl2IcNbUNw/xyAf8Ulc=
X-Google-Smtp-Source: AGHT+IG2LKen8WXlKCVG4rUuv5H4Bl3N4h2X8DwUeXxNFNEgbfsUd99hFbjqhhw3cYiYoTH7LHEqTg==
X-Received: by 2002:a05:690c:6c83:b0:71f:9a36:d339 with SMTP id 00721157ae682-71fdc40fcebmr122974027b3.43.1756150504855;
        Mon, 25 Aug 2025 12:35:04 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71ff18b3794sm19383027b3.63.2025.08.25.12.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 12:35:03 -0700 (PDT)
Date: Mon, 25 Aug 2025 15:35:02 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	kernel-team@fb.com, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH 16/50] fs: change evict_inodes to use iput instead of
 evict directly
Message-ID: <20250825193502.GB1310133@perftesting>
References: <cover.1755806649.git.josef@toxicpanda.com>
 <1198cd4cd35c5875fbf95dc3dca68650bb176bb1.1755806649.git.josef@toxicpanda.com>
 <20250825-entbinden-kehle-2e1f8b67b190@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825-entbinden-kehle-2e1f8b67b190@brauner>

On Mon, Aug 25, 2025 at 11:07:55AM +0200, Christian Brauner wrote:
> On Thu, Aug 21, 2025 at 04:18:27PM -0400, Josef Bacik wrote:
> > At evict_inodes() time, we no longer have SB_ACTIVE set, so we can
> > easily go through the normal iput path to clear any inodes. Update
> 
> I'm a bit lost why SB_ACTIVE is used here as a justification to call
> iput(). I think it's because iput_final() would somehow add it back to
> the LRU if SB_ACTIVE was still set and the filesystem somehow would
> indicate it wouldn't want to drop the inode.
> 
> I'm confused where that would even happen. IOW, which filesystem would
> indicate "don't drop the inode" even though it's about to vanish. But
> anyway, that's probably not important because...
> 
> > dispose_list() to check how we need to free the inode, and then grab a
> > full reference to the inode while we're looping through the remaining
> > inodes, and simply iput them at the end.
> > 
> > Since we're just calling iput we don't really care about the i_count on
> > the inode at the current time.  Remove the i_count checks and just call
> > iput on every inode we find.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> >  fs/inode.c | 26 +++++++++++---------------
> >  1 file changed, 11 insertions(+), 15 deletions(-)
> > 
> > diff --git a/fs/inode.c b/fs/inode.c
> > index 72981b890ec6..80ad327746a7 100644
> > --- a/fs/inode.c
> > +++ b/fs/inode.c
> > @@ -933,7 +933,7 @@ static void evict(struct inode *inode)
> >   * Dispose-list gets a local list with local inodes in it, so it doesn't
> >   * need to worry about list corruption and SMP locks.
> >   */
> > -static void dispose_list(struct list_head *head)
> > +static void dispose_list(struct list_head *head, bool for_lru)
> >  {
> >  	while (!list_empty(head)) {
> >  		struct inode *inode;
> > @@ -941,8 +941,12 @@ static void dispose_list(struct list_head *head)
> >  		inode = list_first_entry(head, struct inode, i_lru);
> >  		list_del_init(&inode->i_lru);
> >  
> > -		evict(inode);
> > -		iobj_put(inode);
> > +		if (for_lru) {
> > +			evict(inode);
> > +			iobj_put(inode);
> > +		} else {
> > +			iput(inode);
> > +		}
> 
> ... Afaict, if we end up in dispose_list() we came from one of two
> locations:
> 
> (1) prune_icache_sb()
>     In which case inode_lru_isolate() will have only returned inodes
>     that prior to your changes would have inode->i_count zero.
> 
> (2) evict_inodes()
>     Similar story, this only hits inodes with inode->i_count zero.
> 
> With your change you're adding an increment from zero for (2) via
> __iget() so that you always end up with a full refcount, and that is
> backing your changes to dispose_list() later.
> 
> I don't see the same done for (1) though and so your later call to
> iput() drops the reference below zero? It's accidently benign because
> iiuc atomic_dec_and_test() will simply tell you that reference count
> didn't go to zero and so iput() will back off. But still this should be
> fixed if I'm right.

Because (1) at this point doesn't have a full reference, it only has an
i_obj_count reference. The next patch converts this, and removes this bit. I did
it this way to clearly mark the change in behavior.

prune_icache_sb() will call dispose_list(&list, true), which will do the
evict(inode) and iobj_put(inode). This is correct because the inodes on the list
from prune_icache_sb() will have an i_count == and have I_WILL_FREE set, so it
will never have it's i_count increased to 1.

The change here is to change evict_inodes() to simply call iput(), as it calls
dispose_list(&list, false). We will increase the i_count to 1 from zero via
__iget(), which at this point in the series is completely correct behavior. Then
we will call iput() which will drop the i_count back to zero, and then call
iput_final, and since SB_ACTIVE is not set, it will call evict(inode) and clean
everything up properly.

> 
> The conversion to iput() is introducing a lot of subtlety in the middle
> of the series. If I'm right then the iput() is a always a nop because in
> all cases it was an increment from zero. But it isn't really a nop
> because we still do stuff like call ->drop_inode() again. Maybe it's
> fine because no filesystem would have issues with this but I wouldn't
> count on it and also it feels rather unclean to do it this way.

So I'm definitely introducing another call to ->drop_inode() here, but
->drop_inode() has always been a "do we want to keep this inode on the LRU"
call, calling it again doesn't really change anything.

That being said it is a subtle functional change. I put it here specifically
because it is a functional change. If it bites us in the ass in some unforseen
way we'll be able to bisect it down to here and then we can all laugh at Josef
because he missed something.

> 
> So, under the assumption, that after the increment from zero you did, we
> really only have a blatant zombie inode on our hands and we only need to
> get rid of the i_count we took make that explicit and do:
> 
> 	if (for_lru) {
> 		evict(inode);
> 		iobj_put(inode);
> 	} else {
> 		/* This inode was always incremented from zero.
> 		 * Get rid of that reference without doing anything else.
> 		 */
> 		WARN_ON_ONCE(!atomic_dec_and_test(&inode->i_count));
> 	}

We still need the evict() to actually free the inode.  We're just getting there
via iput_final() now instead of directly calling evict().

> 
> Btw, for the iobj_put() above, I assume that we're not guaranteed that
> i_obj_count == 1?

Right, it's purely dropping the LRU list i_obj_count reference.  Thanks,

Josef

