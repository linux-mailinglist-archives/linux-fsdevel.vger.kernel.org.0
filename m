Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D389852E379
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 May 2022 06:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbiETEH3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 May 2022 00:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbiETEH0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 May 2022 00:07:26 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F1C14AA62
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 May 2022 21:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6BZRgBn7adw6z/MPepunJ5SXCDpNtK+Aj6yIZsjHZgs=; b=ppC4+raU08BtEmRh27O8Kw5EVA
        VF2IYah/fBqGJL4HpuL+JdbtwFDEsl/vL/Ck/wDUavKddlJt5HidnrIR6dAsL++psvQdhJG/DwdZC
        jJDS6YtMvsuiU5Ycpee/iSMrAyCJvsz/7ZxIjwE2hj5xKJvqTR3VdVwHw71hCNv9mD9BpVgca/eCx
        yRYTPKUJjm3GhJmqbFJRpIaW+XsNnQMU2a+YwMHaJhm1PlxDQyVEHWmzbdeGHNqfItBQFIc1wA4xC
        qmbQW1CA1ozUST3oIDIm1bTnWRJ19AyWPVZtNtRA16Y0k25Wlsb484vGhvVEXr1Wg5UMtVsWfo1KF
        YV4H8KOQ==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nrtv9-00GUhI-IF; Fri, 20 May 2022 04:07:23 +0000
Date:   Fri, 20 May 2022 04:07:23 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Vivek Goyal <vgoyal@redhat.com>,
        Dharmendra Singh <dharamhans87@gmail.com>,
        Bernd Schubert <bschubert@ddn.com>
Subject: Re: [RFC PATCH] vfs: allow ->atomic_open() on positive
Message-ID: <YocT+9pebi3ZBHdn@zeniv-ca.linux.org.uk>
References: <YoZXro9PoYAPUeh5@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoZXro9PoYAPUeh5@miu.piliscsaba.redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 19, 2022 at 04:43:58PM +0200, Miklos Szeredi wrote:
> Hi Al,
> 
> Do you see anything bad with allowing ->atomic_open() to take a positive dentry
> and possibly invalidate it after it does the atomic LOOKUP/CREATE+OPEN?
> 
> It looks wrong not to allow optimizing away the roundtrip associated with
> revalidation when we do allow optimizing away the roundtrip for the initial
> lookup in the same situation.

Details, please - what will your ->atomic_open() do in that case?
