Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6AB02D49F0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Dec 2020 20:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387627AbgLITPs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Dec 2020 14:15:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387481AbgLITPr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Dec 2020 14:15:47 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB632C0613CF
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Dec 2020 11:15:07 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id u12so2602863ilv.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Dec 2020 11:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=SYB1xAfWTeS/joQX7RcuMC3UaVhcoVLTL3PAGbtqL/E=;
        b=RpG0QXxoO2voUuz2pBEJ1WnJLX/us5bjzfm7amI2GLw3T2VWw1fFARYdefJXLVLrdw
         RMJN1JgekyMFEs/PPMdW2w9IyQfAqw3MEHCPYNXqzhKNrY9z5hlW6bzVGxFtSNtjSxNM
         4PzoBp9j2S1iAOUyryRzjFhnHM+V58zLZUh7n5jXv3z4oN3YQLHBR29WKzBm8WHEjBjv
         EltbVh/zOqG1lTRzqDW4H366orlH0ChdTvuZB0meRFAyhm1RSTLLfwkqIjIGgOCrRGrC
         /H6b2OKSgj/uOVovRSPi5q9v8WFlsvKv9tT/ngs0BWZQQlnSY00Kxed3iNBx62d2S9Pk
         khSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=SYB1xAfWTeS/joQX7RcuMC3UaVhcoVLTL3PAGbtqL/E=;
        b=ZBmJmaS4o8B0Pr1UStIRIF1VoivY18h6jhTWZAURqi2AqbGJdt7ESz/oVWkDjohyiH
         qFwvw0HNddd1spRFMzbMS8h2CIcVxcmhF2zUuw8VywW5+1qqfz1mM5eOyAMAuPlApz8t
         YnyNIUMlPy5ZAeDMEp5QNmmL32MxOpmxBx5p+4G4HDlEdYvHWW4l3/bQFIgt093XEi5X
         VU2x+ObFSy7TK9xCi+tYCX3mRdsBf9SNSu4vqfscSgHaAgZP8zThGjqxcJ+cTnPHcMeH
         zzquAmWfvVt9mKZU121Ir7yvgEfi61UgMI+Nfd+hqufNjS0Ycp3yyGV8xvU1fRoPjL9H
         zzbQ==
X-Gm-Message-State: AOAM532oGsLtvUt3/wdg6Su0QRWHAikSoiT4icY7GaUVOHgux5M7bTud
        7bqs9I1WkrzYdKjD5bCz7lLTP3p1pPQz/op2MUNYL+KdP6s=
X-Google-Smtp-Source: ABdhPJzbUldBSsB31KeyaEoo800tOsRHRHt3qc8D4H3sF2wMTLfLBAyRRXQZ8T+JZFkmolapCRDKWCw7k+HfT3Q9LAU=
X-Received: by 2002:a05:6e02:14ce:: with SMTP id o14mr4965185ilk.9.1607541305541;
 Wed, 09 Dec 2020 11:15:05 -0800 (PST)
MIME-Version: 1.0
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 9 Dec 2020 21:14:53 +0200
Message-ID: <CAOQ4uxiOMeGD212Lt6_udbDb6f6M+dt4vUrZz_2Qt-tuvAt--A@mail.gmail.com>
Subject: FAN_CREATE_SELF
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jan,

I have a use case with a listener that uses FAN_REPORT_FID mode.
(fid is an index to a db).
Most of the time fid can be resolved to the path and that is sufficient.
If it cannot, the file will be detected by a later dir scan.

I find that with most of the events this use case can handle the events
efficiently without the name info except for FAN_CREATE.

For files, with most applications, FAN_CREATE will be followed by
some other event with the file fid, but it is not guaranteed.
For dirs, a single FAN_CREATE event is more common.

I was thinking that a FAN_CREATE_SELF event could be useful in some
cases, but I don't think it is a must for closing functional gaps.
For example, another group could be used with FAN_REPORT_DFID_NAME
to listen on FAN_CREATE events only, or on FAN_CREATE (without name)
the dir can be scanned, but it is not ideal.

Before composing a patch I wanted to ask your opinion on the
FAN_CREATE_SELF event. Do you have any thoughts on this?

Thanks,
Amir.
