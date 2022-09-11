Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 344515B507C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Sep 2022 20:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbiIKSMU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Sep 2022 14:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiIKSMT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Sep 2022 14:12:19 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9B022BE8
        for <linux-fsdevel@vger.kernel.org>; Sun, 11 Sep 2022 11:12:18 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id 129so6850876vsi.10
        for <linux-fsdevel@vger.kernel.org>; Sun, 11 Sep 2022 11:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=MdACtTIYM/2097Ho5W+lbIMb7ExDthICSGcM+t0t6PY=;
        b=UCHfYNMXiGi5u8r7iIAJnpWeEXKrqLzz5eoBy0yVj8RWFU0mf1g1fLn9j9wp36/6nl
         wwSHnKPQnzVdQ6IxrryzUKLCQrqvVrt2hN/FZVQhIqz1XzEhXbmLa4ylpoKYIAT4SkSw
         K+ZWVTlJ1LCPOvobzbAShGxaM87c8LbV0oGuDJr3RUHz1NSWLpfzV9xg7xsWTWRXeUBu
         PPjpwnoM04LLutYUFCuFDAevrju6V/5qzK4USCfGV3Idzay3bOXuyQUvqnVg5Z7btZ+M
         CqqSweQXb6mggN/wf17AMowBKxBrj6A3E7loLcxmqtwcElLBjwi5mjbIB93lm8uINTtM
         68TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=MdACtTIYM/2097Ho5W+lbIMb7ExDthICSGcM+t0t6PY=;
        b=ur0Qt6gIlaojQ3FdZR2FLvmusXx/4GvSlHEZLWpEezq+Lc/lyl9ciBEMSXMR4EWBT6
         6MxRBC7FHfSZd+e9e6avdU26pJ0Rh+SirAMD5Mg0cBHDKxYNBk95nRmn9mfl4CKMROVN
         H1OHyFWaTtst0pzj0meX2RkCxFrqclZ5LiaGFyYxrQNhQG00LPke4ZkoBjmPUmNibGX6
         EL8Kt73zmgIB6RrQNud8ulKMwLEEb5qnEW1H8ASvPzAfpZWf/LVKgrL289iW/s9VYNHk
         ha/xuCvVMn7wyUCtUHkC/OSoQ/3dinBeBs1WboGz7yoCjh/nQ0wmNcewrBV6svQ2geFR
         XWyA==
X-Gm-Message-State: ACgBeo0O6Ji2hF2q9E/PY1kwjHp7c8D34wGstUwZ2jouwUA+luZWD1o6
        G8pDB2aoypzMU/qYCX1dZVgv6idoPuPomw7Gb60KLfQoINU=
X-Google-Smtp-Source: AA6agR4AtY/ZDVp3Z9juNY3B8HObOAQbWbZ0Ez5GRnePHJmZgkFN4ldtvQ7MI84u9AQKJXnEmfOgjgH4e7pQeedB/IM=
X-Received: by 2002:a05:6102:14b:b0:398:2e7c:4780 with SMTP id
 a11-20020a056102014b00b003982e7c4780mr5726489vsr.72.1662919937846; Sun, 11
 Sep 2022 11:12:17 -0700 (PDT)
MIME-Version: 1.0
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 11 Sep 2022 21:12:06 +0300
Message-ID: <CAOQ4uxhrQ7hySTyHM0Atq=uzbNdHyGV5wfadJarhAu1jDFOUTg@mail.gmail.com>
Subject: thoughts about fanotify and HSM
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jan,

I wanted to consult with you about preliminary design thoughts
for implementing a hierarchical storage manager (HSM)
with fanotify.

I have been in contact with some developers in the past
who were interested in using fanotify to implement HSM
(to replace old DMAPI implementation).

Basically, FAN_OPEN_PERM + FAN_MARK_FILESYSTEM
should be enough to implement a basic HSM, but it is not
sufficient for implementing more advanced HSM features.

Some of the HSM feature that I would like are:
- blocking hook before access to file range and fill that range
- blocking hook before lookup of child and optionally create child

My thoughts on the UAPI were:
- Allow new combination of FAN_CLASS_PRE_CONTENT
  and FAN_REPORT_FID/DFID_NAME
- This combination does not allow any of the existing events
  in mask
- It Allows only new events such as FAN_PRE_ACCESS
  FAN_PRE_MODIFY and FAN_PRE_LOOKUP
- FAN_PRE_ACCESS and FAN_PRE_MODIFY can have
  optional file range info
- All the FAN_PRE_ events are called outside vfs locks and
  specifically before sb_writers lock as in my fsnotify_pre_modify [1]
  POC

That last part is important because the HSM daemon will
need to make modifications to the accessed file/directory
before allowing the operation to proceed.

Naturally that opens the possibility for new userspace
deadlocks. Nothing that is not already possible with permission
event, but maybe deadlocks that are more inviting to trip over.

I am not sure if we need to do anything about this, but we
could make it easier to ignore events from the HSM daemon
itself if we want to, to make the userspace implementation easier.

Another thing that might be good to do is provide an administrative
interface to iterate and abort pending fanotify permission/pre-content
events.

You must have noticed the overlap between my old persistent
change tracking journal and this design. The referenced branch
is from that old POC.

I do believe that the use cases somewhat overlap and that the
same building blocks could be used to implement a persistent
change journal in userspace as you suggested back then.

Thoughts?

Amir.

[1] https://github.com/amir73il/linux/commits/fsnotify_pre_modify
