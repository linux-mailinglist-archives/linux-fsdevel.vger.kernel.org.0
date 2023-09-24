Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97EEA7AC77B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Sep 2023 12:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjIXKPp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 Sep 2023 06:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjIXKPp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 Sep 2023 06:15:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8DF103;
        Sun, 24 Sep 2023 03:15:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59B20C433C8;
        Sun, 24 Sep 2023 10:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695550538;
        bh=CS7pDvTt2JHaj6m+3Z8/xPptzhM5tKLfRkWfD02y0eU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E93A5bEUrkz2T5GcGDtBkeJFpF7sSOmeTsGpP4uguyS07HPpSJAr9r5RJ6q+vuEUF
         +oSf1dojKeaaNGK7OmeRV8lfDveFDkD7aa3vwAZ5sP46XbVGxNVvmOfiIfUud3fMnV
         gR2tjlIivnRc+AjnBkCsg9vHCFr6Fg8SaEVzGtp+IMuX/uzjTkqFakbPtaIpGeN8Zo
         4tpJ+G8c7hFIxI0f5l5ZADWeKzg0XEJb8+fEf/t7Z2WrbeTyKeEc93Ykcsr0JYWvh9
         l1xkINdwy8svI8IlM4S2YXXl6YcVETSspf6g/2PTGFTJMQ5OrI7v68Ws3tLT6wJhh5
         HlxjsvL+oQewQ==
Date:   Sun, 24 Sep 2023 12:15:34 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>
Subject: Re: [GIT PULL v2] timestamp fixes
Message-ID: <20230924-zementieren-milan-89b5b2650821@brauner>
References: <20230921-umgekehrt-buden-a8718451ef7c@brauner>
 <CAHk-=wgoNW9QmEzhJR7C1_vKWKr=8JoD4b7idQDNHOa10P_i4g@mail.gmail.com>
 <0d006954b698cb1cea3a93c1662b5913a0ded3b1.camel@kernel.org>
 <CAOQ4uxi=377CcOLf4ySoZWVMRkGPdnxhL-Vw4OM28mz_xeK97w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOQ4uxi=377CcOLf4ySoZWVMRkGPdnxhL-Vw4OM28mz_xeK97w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> As luck would have it, if my calculations are correct, on x86-64 and with

I hope you're aware that you can use pahole to get struct layouts and
that you don't have to manually calculate this...

> CONFIG_FS_POSIX_ACL=y, CONFIG_SECURITY=y (as they are on
> distro kernels), __i_ctime is exactly on split cache lines and maybe even

(Make sure that your kernel doesn't use randomize_layout...)

tv_nsec has always been on a split cacheline. We've optimized struct
file a little bit in the same way before as there were actual
regressions in some workloads

I can put it into one of the vfs.git perf branches that are tested by
LKP to see if there's any actual performance changes.

5.15:
        /* --- cacheline 1 boundary (64 bytes) --- */
        long unsigned int          i_ino;                                                /*    64     8 */
        union {
                const unsigned int i_nlink;                                              /*    72     4 */
                unsigned int       __i_nlink;                                            /*    72     4 */
        };                                                                               /*    72     4 */
        /* typedef dev_t -> __kernel_dev_t -> u32 -> __u32 */ unsigned int               i_rdev; /*    76     4 */
        /* typedef loff_t -> __kernel_loff_t */ long long int              i_size;       /*    80     8 */
        struct timespec64 {
                /* typedef time64_t -> __s64 */ long long int      tv_sec;               /*    88     8 */
                long int           tv_nsec;                                              /*    96     8 */
        }i_atime; /*    88    16 */
        struct timespec64 {
                /* typedef time64_t -> __s64 */ long long int      tv_sec;               /*   104     8 */
                long int           tv_nsec;                                              /*   112     8 */
        }i_mtime; /*   104    16 */
        struct timespec64 {
                /* typedef time64_t -> __s64 */ long long int      tv_sec;               /*   120     8 */
                /* --- cacheline 2 boundary (128 bytes) --- */
                long int           tv_nsec;                                              /*   128     8 */
        }i_ctime; /*   120    16 */
        /* typedef spinlock_t */ struct spinlock {

6.6:
        /* --- cacheline 1 boundary (64 bytes) --- */
        long unsigned int          i_ino;                                                /*    64     8 */
        union {
                const unsigned int i_nlink;                                              /*    72     4 */
                unsigned int       __i_nlink;                                            /*    72     4 */
        };                                                                               /*    72     4 */
        /* typedef dev_t -> __kernel_dev_t -> u32 -> __u32 */ unsigned int               i_rdev; /*    76     4 */
        /* typedef loff_t -> __kernel_loff_t */ long long int              i_size;       /*    80     8 */
        struct timespec64 {
                /* typedef time64_t -> __s64 */ long long int      tv_sec;               /*    88     8 */
                long int           tv_nsec;                                              /*    96     8 */
        }i_atime; /*    88    16 */
        struct timespec64 {
                /* typedef time64_t -> __s64 */ long long int      tv_sec;               /*   104     8 */
                long int           tv_nsec;                                              /*   112     8 */
        }i_mtime; /*   104    16 */
        struct timespec64 {
                /* typedef time64_t -> __s64 */ long long int      tv_sec;               /*   120     8 */
                /* --- cacheline 2 boundary (128 bytes) --- */
                long int           tv_nsec;                                              /*   128     8 */
        }__i_ctime; /*   120    16 */
