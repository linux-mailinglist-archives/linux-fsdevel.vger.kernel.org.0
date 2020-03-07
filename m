Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A704B17CB79
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Mar 2020 04:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgCGDSc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Mar 2020 22:18:32 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:38204 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbgCGDSc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Mar 2020 22:18:32 -0500
Received: by mail-yw1-f67.google.com with SMTP id 10so4306235ywv.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Mar 2020 19:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZIJXxg0ubUyqCRqtFa70jhlNgjVApQYDh3EGrv9Ybao=;
        b=JkPh12pbQ4kMxM20UpIeVvtR0G6dF00j981YXt+yjrq+kh4jNLC3rqvjwyETyyrJ87
         T9CYcD9W3P5CfJO9ZXXWpf1+ZaPC29pF9x4apt6WtumTWxe+z2YHha+vC7KzOTaSszXd
         BR/uMIDB/ktBzG89pkbA0YAOdhHq/cS1z7t5bVrFvo32ug65G596RufS9USWRsq3aXYs
         cUNUrS8wvVNNt0rV90+YhbqMukuGwVgGr5iGo4ok9TP6GCvngsSCAYXILEbo7jZAUZIN
         hLxHJ5QuIMJj2BOlgr1xmBD87K2GpRdMiId9hnbuhLi1GP5gJhUg9QaU3Z32Fibgskuq
         2kag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZIJXxg0ubUyqCRqtFa70jhlNgjVApQYDh3EGrv9Ybao=;
        b=Yhvf6J0K4XklvfL6nI98UV0Icm2pv3S7sSik+VmpraCAc9O0bdEyO6KybKz/X20HXV
         iWBg8Gz9VuT6lKSnsfQu5t1zn9W14B7vI1OPD9r0y/nbXT7DFsoHh0AaeZo2/S2cvySn
         Ou2WXfWWrrZ38Q65gN7oYbEy62ojerkyGWGH68RK1JW0mRMUZSjlqe5NwAO0Vq9d63Cz
         kv0DvbsPirzPeBNsPTEHGdcLOGKu7XEhytnfCmA5efrQuCRZCn/49F8zoP9ISbWK49BM
         qaAkZrz7EXMxHOfz/R3rQSXB9dRniZZ7CYC6FfBzR8wYg/PqB6baIfNHyyI5saQiUKvZ
         RtsA==
X-Gm-Message-State: ANhLgQ3ijKgNqqxOitf54juUzmqjjiS7NUvM61dO+tX0rPlGc7IyxscF
        3kau2zd2DXHAQzHmrh5FFVVTSqntZQWBZYjxIPY=
X-Google-Smtp-Source: ADFU+vtVx6ap+CR1eOZK2PhU2DJmItdkMAmFUH32PLgMRAGeYufRXIa7B2Ni3mnsIG9+Zas9Zr9qN72a5kOp2FaKD5M=
X-Received: by 2002:a25:c68c:: with SMTP id k134mr7000548ybf.85.1583551111350;
 Fri, 06 Mar 2020 19:18:31 -0800 (PST)
MIME-Version: 1.0
References: <20200213193534.GP11244@42.do-not-panic.com>
In-Reply-To: <20200213193534.GP11244@42.do-not-panic.com>
From:   Steve French <smfrench@gmail.com>
Date:   Fri, 6 Mar 2020 21:18:20 -0600
Message-ID: <CAH2r5mt86s4BDKf8PLEEHd0a7=4QOG-wmikFez28CJxjoChdPw@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Increasing automation of filesystem testing
 with kdevops
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     lsf-pc@lists.linux-foundation.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Eryu Guan <guaneryu@gmail.com>, Jan Kara <jack@suse.cz>,
        Mel Gorman <mgorman@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Improving the automation of fs testing is hugely important - with SMB3
testing (cifs.ko kernel client and now kernel server) we leverage the
buildbot and many xfstests against five distinct server types.   NFS
and SMB3 mounts can be used to save off tests, images, git trees etc.

But ... trying to get the tests to run for sane lengths (we are up to
more than 4 hours for our default regression bucket which is a little
longer than I would like) is not trivial and proving code coverage
value of adding additional tests and finding holes in what xfstests
doesn't cover is not as easy as it sounds.

On Thu, Feb 13, 2020 at 2:12 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> Ever since I've taken a dive into filesystems I've been trying to
> further automate filesytem setup / testing / collection of results.
> I had looked at xfstests-bld [0] but was not happy with it being cloud
> specific to Google Compute Engine, and so I have been shopping around
> for technology / tooling which would be cloud agnostic / virtualization
> agnostic.
>
> At the last LSFMM in Puerto Rico the project oscheck [1] was mentioned a
> few times as a mechanism as to how to help get set up fast with fstests,
> however *full* automation to include running the tests, processing
> results, and updating a baseline was really part of the final plan.
> I had not completed the work yet by LSFM Puerto Rico, so could not
> talk about the work. The majority of the effort is now complete
> and is part of kdevops [2], now a more generic framework to help automated
> kernel development testing. I've written a tiny bit about it [3]. Due to
> the nature of LSFMM I don't want to present the work, unless folks
> really want me to, so would rather have a discussion over technologies
> used, pain points to consider, some future ideas, and see what others
> are doing. May be worth just as a simple BoF.
>
> So let me start in summary style with some of these on my end.
>
> Technologies used:
>
>   * vagrant / terraform
>   * ansible
>
> Pain points:
>
>   * What fstests doesn't cover, or an auto-chinner needed:
>     - fsmark regressions, for instance:
>       https://lkml.org/lkml/2013/9/10/46
>   * vagrant-libvirt is not yet part of upstream vagrant but neeed
>     for use with KVM
>   * Reliance on only one party (Hashi Corp) for the tooling, even though
>     its all open source
>   * Vagrant's dependency on ruby and several ruby gems
>   * terraform's reliance on tons of go modules
>   * "Enterpise Linux" considerations for all the above
>
> Future ideas:
>
>   * Using 9pfs for sharing git trees
>   * Does xunit suffice?
>   * Evaluating which tests can be folded under kunit
>   * Evaluating running one test per container so to fully parallelize testing
>
> [0] https://git.kernel.org/pub/scm/fs/ext2/xfstests-bld.git
> [1] https://github.com/mcgrof/oscheck
> [2] https://github.com/mcgrof/kdevops
> [3] https://people.kernel.org/mcgrof/kdevops-a-devops-framework-for-linux-kernel-development
>
>   Luis



-- 
Thanks,

Steve
