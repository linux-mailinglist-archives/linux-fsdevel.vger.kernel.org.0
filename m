Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75CF878EA0D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Aug 2023 12:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236378AbjHaKSg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Aug 2023 06:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjHaKSe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Aug 2023 06:18:34 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8C8CED;
        Thu, 31 Aug 2023 03:18:30 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-99df431d4bfso69757066b.1;
        Thu, 31 Aug 2023 03:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693477108; x=1694081908; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W0dJ41GEaj0gesWJLqUgGbnWRKUvfWKRnsQAEBpf6Ts=;
        b=fXbViCwi3HYG0N2wd3TRMJopEp41AxXNzd7LR45Mq9duuX2MgnX97FF837PXUqBptc
         saQHuHOiO9fE/8R7VyVTVRY52l/qfYtHRCwG/+KcXVaeYoD4pUv6dJD55jRI7g1VZY/S
         SIRoDqf9ZHF8ew83kSnrL86A7/gJojVuMC3smoSySDr7CzpinOoXeeEhrj5hvflqggm7
         xPNZnXqWJZycFWwoTmAHLRCBTP9/SxZ0TvOIJjfdOFQ3YP+89j4msUaCXz2KKIJ2hcY4
         MHpidlFGcMdf5PHL7zt3FhigvkttEI3tKZ3nVa3G/sQrEv1Pg3uualtrPy3gIjFSm/Vy
         vJ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693477108; x=1694081908;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W0dJ41GEaj0gesWJLqUgGbnWRKUvfWKRnsQAEBpf6Ts=;
        b=c4dounvCDkIo4BR4RgW+o9LxCxCLlSGcN8c5bPK96vki5lcGmtpKgGYiJdyCDWWrXk
         jmPBAp2JeGpDp+bcvTREOnFs/yB0LmTBL6mhNUB4G25TC1u3KS9OUluwL8ch7fmSC6bo
         vqFBh4igQNzX9ZLa+yL8qXJE452fbm9ByyohZi8NdtYqxx54SZ6M5HeXbWKH77SML4LT
         hcDm1q83680Nq0mfSBQ3p0idb4TftNuRXyXRYsScfgBy3zaDlaTAzxUz0Oh2bAs4r3Q1
         DKwXa7qP/h6IsiFp6vdj7C/KZ+bxCyZT67QEuNXZma2fDqVpaOYDjycfcf7UOl7Bz9Uc
         b7/g==
X-Gm-Message-State: AOJu0Ywjt+NKqR1sEj3nQ7EfgL9nuivz+R9d28SfgBIiS+f1o1EW2X5d
        JmXpz4Bvwn6AKdpsZKO+qfw=
X-Google-Smtp-Source: AGHT+IE4PertcNGBWspdPA3JtDTi9EfIYMhnlO6FP2LSBknwiJKfumbWAe7W0Ot743yQyxWCNxLToQ==
X-Received: by 2002:a17:907:78d4:b0:9a1:bd82:de35 with SMTP id kv20-20020a17090778d400b009a1bd82de35mr3540929ejc.3.1693477108259;
        Thu, 31 Aug 2023 03:18:28 -0700 (PDT)
Received: from f (cst-prg-30-15.cust.vodafone.cz. [46.135.30.15])
        by smtp.gmail.com with ESMTPSA id gj17-20020a170906e11100b009929ab17bdfsm585491ejb.168.2023.08.31.03.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 03:18:27 -0700 (PDT)
Date:   Thu, 31 Aug 2023 12:18:24 +0200
From:   Mateusz Guzik <mjguzik@gmail.com>
To:     Bernd Schubert <bschubert@ddn.com>
Cc:     linux-fsdevel@vger.kernel.org, bernd.schubert@fastmail.fm,
        miklos@szeredi.hu, dsingh@ddn.com,
        Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH 0/2] Use exclusive lock for file_remove_privs
Message-ID: <20230831101824.qdko4daizgh7phav@f>
References: <20230830181519.2964941-1-bschubert@ddn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230830181519.2964941-1-bschubert@ddn.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 30, 2023 at 08:15:17PM +0200, Bernd Schubert wrote:
> While adding shared direct IO write locks to fuse Miklos noticed
> that file_remove_privs() needs an exclusive lock. I then
> noticed that btrfs actually has the same issue as I had in my patch,
> it was calling into that function with a shared lock.
> This series adds a new exported function file_needs_remove_privs(),
> which used by the follow up btrfs patch and will be used by the
> DIO code path in fuse as well. If that function returns any mask
> the shared lock needs to be dropped and replaced by the exclusive
> variant.
> 

No comments on the patchset itself.

So I figured an assert should be there on the write lock held, then the
issue would have been automagically reported.

Turns out notify_change has the following:
        WARN_ON_ONCE(!inode_is_locked(inode));

Which expands to:
static inline int rwsem_is_locked(struct rw_semaphore *sem)
{
        return atomic_long_read(&sem->count) != 0;
}

So it does check the lock, except it passes *any* locked state,
including just readers.

According to git blame this regressed from commit 5955102c9984
("wrappers for ->i_mutex access") by Al -- a bunch of mutex_is_locked
were replaced with inode_is_locked, which unintentionally provides
weaker guarantees.

I don't see a rwsem helper for wlock check and I don't think it is all
that beneficial to add. Instead, how about a bunch of lockdep, like so:
diff --git a/fs/attr.c b/fs/attr.c
index a8ae5f6d9b16..f47e718766d1 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -387,7 +387,7 @@ int notify_change(struct mnt_idmap *idmap, struct dentry *dentry,
        struct timespec64 now;
        unsigned int ia_valid = attr->ia_valid;

-       WARN_ON_ONCE(!inode_is_locked(inode));
+       lockdep_assert_held_write(&inode->i_rwsem);

        error = may_setattr(idmap, inode, ia_valid);
        if (error)

Alternatively hide it behind inode_assert_is_wlocked() or whatever other
name.

I can do the churn if this sounds like a plan.

