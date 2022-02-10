Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 006544B1444
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Feb 2022 18:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241663AbiBJRcG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Feb 2022 12:32:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiBJRcG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Feb 2022 12:32:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 80B452649
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Feb 2022 09:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644514325;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gKFnzr3mw42+cLmY82j9IW2wooukdLwJVlZhUwWFhlU=;
        b=HMENhltH2+y6zeWg4AQBqZz+U3TqdGN+u//k2I1c/Xr7DCQ7eaoGv4mlMLD49BH3XwG8cS
        nWKnN1Z3j1SFrax3pJN8znQF36Z5iXFaS1ar9ZeXdWHFWOUFA5SE7ETuEt7Gc2k79qEZxd
        zSEpQ4rq2mE4FcUwszWlz5cZzzQJPqs=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-608-thC-VJ7eNWOJcBvJIH8ddw-1; Thu, 10 Feb 2022 12:32:04 -0500
X-MC-Unique: thC-VJ7eNWOJcBvJIH8ddw-1
Received: by mail-qk1-f198.google.com with SMTP id a134-20020ae9e88c000000b0047ebe47102dso4043994qkg.18
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Feb 2022 09:32:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=gKFnzr3mw42+cLmY82j9IW2wooukdLwJVlZhUwWFhlU=;
        b=oNJh8qLcqQkLt/HnaQdCFLXsVYCOaVeLC6siux3X/B/mCUuWoqInQibKSMFMYO+JzK
         7tj89fohMD1vWVARkqYEJ6jrE3+esNtr9aR91bmxxQspgHnIb6ebTgfyB/48rKBbOWUH
         Zg2HkB3So1u0Q65uxFeVp5YXZ6md/q1/IQdSokQYnwdkDSRC4Modmm/pD27DbdAsqZMS
         6ofYqR5QbPsM4pQWIPMuNQVO+AUOiNp9s2+Tv6xlRa5/loNYYsFHrjrDnlq/FJVCXBQ2
         gOwsdZPWqx2pXxdeiMxp38e2600ziMJbP/S9xG/TTir9yeaMNMfmJCZMoPUHW5Kaxpa3
         p9kg==
X-Gm-Message-State: AOAM533Q5ZULF5fcAEpqHpaDbOe12n9E5hpNfbpEnq9BnXdVbZa6PIoY
        yrSWlk4RMh4XI+icY1xPOlA6NfNU+UKqjO64/5YU3JovlQhYndnLKrq5tFOaqtLUPXhrC6C8cBq
        qZ8SPzWdXm9Xq0fbegakGqGZF+A==
X-Received: by 2002:ac8:5d8e:: with SMTP id d14mr5570349qtx.278.1644514323456;
        Thu, 10 Feb 2022 09:32:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz24bjw/li4d++11Tr6sKRRTIK+JHKdr4CaSbu5BNNRZFHqf2AlI0qo+B+Zlp3w3EvzXsJumQ==
X-Received: by 2002:ac8:5d8e:: with SMTP id d14mr5570332qtx.278.1644514323208;
        Thu, 10 Feb 2022 09:32:03 -0800 (PST)
Received: from [192.168.1.3] (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id bk23sm10146791qkb.3.2022.02.10.09.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 09:32:02 -0800 (PST)
Message-ID: <76dbd9cebe142067b9322d66c23f9b77f8075cf0.camel@redhat.com>
Subject: Re: [PATCH RFC v12 1/3] fs/lock: add new callback,
 lm_lock_conflict, to lock_manager_operations
From:   Jeff Layton <jlayton@redhat.com>
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Bruce Fields <bfields@fieldses.org>
Cc:     Dai Ngo <dai.ngo@oracle.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Date:   Thu, 10 Feb 2022 12:32:02 -0500
In-Reply-To: <2AEF8E7D-2F4E-4D88-8B71-48195C6E45ED@oracle.com>
References: <1644468729-30383-1-git-send-email-dai.ngo@oracle.com>
         <1644468729-30383-2-git-send-email-dai.ngo@oracle.com>
         <20220210142826.GD21434@fieldses.org>
         <2AEF8E7D-2F4E-4D88-8B71-48195C6E45ED@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2022-02-10 at 16:50 +0000, Chuck Lever III wrote:
> 
> > On Feb 10, 2022, at 9:28 AM, J. Bruce Fields <bfields@fieldses.org> wrote:
> > 
> > On Wed, Feb 09, 2022 at 08:52:07PM -0800, Dai Ngo wrote:
> > > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > > index bbf812ce89a8..726d0005e32f 100644
> > > --- a/include/linux/fs.h
> > > +++ b/include/linux/fs.h
> > > @@ -1068,6 +1068,14 @@ struct lock_manager_operations {
> > > 	int (*lm_change)(struct file_lock *, int, struct list_head *);
> > > 	void (*lm_setup)(struct file_lock *, void **);
> > > 	bool (*lm_breaker_owns_lease)(struct file_lock *);
> > > +	/*
> > > +	 * This callback function is called after a lock conflict is
> > > +	 * detected. This allows the lock manager of the lock that
> > > +	 * causes the conflict to see if the conflict can be resolved
> > > +	 * somehow. If it can then this callback returns false; the
> > > +	 * conflict was resolved, else returns true.
> > > +	 */
> > > +	bool (*lm_lock_conflict)(struct file_lock *cfl);
> > > };
> > 
> > I don't love that name.  The function isn't checking for a lock
> > conflict--it'd have to know *what* the lock is conflicting with.  It's
> > being told whether the lock is still valid.
> > 
> > I'd prefer lm_lock_expired(), with the opposite return values.
> 
> Or even lm_lock_is_expired(). I agree that the sense of the
> return values should be reversed.
> 
> 
> The block comment does not belong in struct lock_manager_operations,
> IMO.
> 
> Jeff's previous review comment was:
> 
> > > @@ -1059,6 +1062,9 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
> > > 		list_for_each_entry(fl, &ctx->flc_posix, fl_list) {
> > > 			if (!posix_locks_conflict(request, fl))
> > > 				continue;
> > > +			if (fl->fl_lmops && fl->fl_lmops->lm_lock_conflict &&
> > > +				!fl->fl_lmops->lm_lock_conflict(fl))
> > > +				continue;
> > 
> > The naming of this op is a little misleading. We already know that there
> > is a lock confict in this case. The question is whether it's resolvable
> > by expiring a tardy client. That said, I don't have a better name to
> > suggest at the moment.
> > 
> > A comment about what this function actually tells us would be nice here.
> 
> 
> I agree that a comment that spells out the API contract would be
> useful. But it doesn't belong in the middle of struct
> lock_manager_operations, IMO.
> 
> I usually put such information in the block comment that precedes
> the individual functions (nfsd4_fl_lock_conflict in this case).
> 
> Even so, the patch description has this information already.
> Jeff, I think the patch description is adequate for this
> purpose -- more information appears later in 3/3. What do you
> think?
> 

I'd be fine with that.
-- 
Jeff Layton <jlayton@redhat.com>

