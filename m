Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2EE532DC5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 May 2022 17:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234881AbiEXPpG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 May 2022 11:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233767AbiEXPpF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 May 2022 11:45:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2820595A11
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 May 2022 08:45:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DBF68B81978
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 May 2022 15:45:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D823C34113;
        Tue, 24 May 2022 15:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653407101;
        bh=gSTlJls8eKq6hngZP1TMVQMwfk9CyRfhgN5h37rMOPQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vNfAWFkpCLUIcrtX7yqutYDjUgyqiluHHlgBjL3QBeJkcFhw0qJXMRPlYqQzxwjRa
         z5FMkUQV1ZftCvf1V8Dqv2+Y+UpF04NfgkcOdRc/uMbkI3g+3PV1r+JtZWlg8n9xTg
         U+EF1n7KuEjxIEHENvAuGsJ3O8rwA2SgTSDn0bF2P/KxJOdguTK9fvX4jkitUDzneY
         RBw+stBxO4zxm8AVJc6hEpiDsW5Agtqt2UMNtxshbReGZuPrygwhtDWbH9BJbtIg27
         JBvoPENcWtVmC27HNtDjcp2+iiVbSE39CLpaFYdJ68UhmXr7pvEcytho3n7QyIrNOv
         HDwKSAy8jRhpw==
Date:   Tue, 24 May 2022 17:44:55 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Dave Marchevsky <davemarchevsky@fb.com>,
        linux-fsdevel@vger.kernel.org,
        Seth Forshee <sforshee@digitalocean.com>,
        Rik van Riel <riel@surriel.com>,
        kernel-team <kernel-team@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>, Chris Mason <clm@fb.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] fuse: allow CAP_SYS_ADMIN in root userns to access
 allow_other mount
Message-ID: <20220524154455.khecrq5ra5olj7am@wittgenstein>
References: <20211112101307.iqf3nhxgchf2u2i3@wittgenstein>
 <0515c3c8-c9e3-25dd-4b49-bb8e19c76f0d@fb.com>
 <CAJfpegtBuULgvqSkOP==HV3_cU2KuvnywLWvmMTGUihRnDcJmQ@mail.gmail.com>
 <d6f632bc-c321-488d-f50e-749d641786d6@fb.com>
 <20220518112229.s5nalbyd523nxxru@wittgenstein>
 <CAJfpegtNKbOzu0F=-k_ovxrAOYsOBk91e3v6GPgpfYYjsAM5xw@mail.gmail.com>
 <CAEf4BzaNjPMgBWuRH_me=+Gp6_nmuwyY7L-wiGFs6G=5A=fQ4g@mail.gmail.com>
 <20220519085919.yqj2hvlzg7gpzby3@wittgenstein>
 <CAEf4BzY5en_O9NtKUB=1uHkGdHLSo_FqddUkokh7pcEWAQ2omw@mail.gmail.com>
 <CAJfpeguOHRtmWTuQfUT_Lb98ddiyzZcjk=D8WyyYA8i923-Lag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfpeguOHRtmWTuQfUT_Lb98ddiyzZcjk=D8WyyYA8i923-Lag@mail.gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 24, 2022 at 09:07:34AM +0200, Miklos Szeredi wrote:
> On Tue, 24 May 2022 at 06:36, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> 
> > I still think that tools like perf being able to provide good tracing
> > data is going to hurt due to this cautious rejection of access, but
> > with Kconfig we at least give an option for users to opt out of it.
> > WDYT?
> 
> I'd rather use a module option for this, always defaulting to off .
> Then sysadmin then can choose to turn this protection off if
> necessary. This would effectively be the same as "user_allow_other"
> option in /etc/fuse.conf, which fusermount interprets but the kernel
> doesn't.

Agreed. Should be properly documented.

Christian
