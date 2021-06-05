Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3686C39CA80
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Jun 2021 20:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbhFES1c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Jun 2021 14:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbhFES1b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Jun 2021 14:27:31 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985B7C061766
        for <linux-fsdevel@vger.kernel.org>; Sat,  5 Jun 2021 11:25:43 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id b12so357303plg.11
        for <linux-fsdevel@vger.kernel.org>; Sat, 05 Jun 2021 11:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:in-reply-to:references:from:mime-version:content-id
         :date:message-id;
        bh=Sj8R2OLtu20ezahDTWPDqbPeVSB8wwQMNYSXeKWf6XI=;
        b=Qm6wbr+DsIGnzCbQYBoURetRzAf/puoUBzuJMSaA9KiM1IIedyPaEnFDxfgB8zL91y
         H3ddgHKJdCT69j3FV6p70wSZK+JEFGibWGyg/160muBYc3rMGzWf0djOtKM/QPwCO362
         eP6nKkN0TpNEpssk/Ezy5P4aQLL8tbuAed7F6dy/v0pH/Qf0Sua859n6HFehayLV6lut
         qYAJS1dCReNUGMsLYXFVNv8cGpzXaMZeMbpO2arNDDmPwHK3YZhKXxknW5rPNwUjYq2Q
         zlmPdaulXtuMqrQ17BaFLwGq2AHIv/7Q33HwHMNp4ObJ+l0MofyQXg380cKQY6N8YvgV
         IgZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:in-reply-to:references:from
         :mime-version:content-id:date:message-id;
        bh=Sj8R2OLtu20ezahDTWPDqbPeVSB8wwQMNYSXeKWf6XI=;
        b=Azu/Y3bJiZxmRhXXSJqzZ8c78RWNkiyv3NzHH+5+JLzXbuKfTZwCEo4145qJOhLPgT
         Q1JyLeSjiSVSycBsEScRynO+A9SxEgtRSpLSPKoz+Q98VZuMhiFhePsP/ohO9fAqDAz9
         xExnXXO50so8RWgzIpXWVzah7B4OoY21GFUeBmLq5NBUK8n6QWdqe5AlPcttujePwxjO
         m2zqh+yujMpk/jSdWZqmAOuprek2PXedc8C1bM1JC48mH3Ho7XZ1aZLAwNYmLCqIzjGh
         06sitcAl2ySE85hcVD9A7KyS77Ay/jxaEnwtuQ2X7Y+yCIBexRjPGmcOphm5RmV4HtNP
         OpcA==
X-Gm-Message-State: AOAM530xI0cp52Y3os2FJB0UL3bFnu0rRu5XJqLmxQORFWfiRMpGkXTS
        rB8XwNVJvlYfzRR6zA1n9DRhdLpS1vM=
X-Google-Smtp-Source: ABdhPJxZSawktermWflNEMA8UHf6z5xpmD820E3eu04/dMk3mzRSgULVl2emY9oclW89o/vIC4tLKA==
X-Received: by 2002:a17:902:6a84:b029:f3:f285:7d8 with SMTP id n4-20020a1709026a84b02900f3f28507d8mr9906634plk.57.1622917543097;
        Sat, 05 Jun 2021 11:25:43 -0700 (PDT)
Received: from jrobl (h219-110-108-104.catv02.itscom.jp. [219.110.108.104])
        by smtp.gmail.com with ESMTPSA id g8sm4807664pgo.10.2021.06.05.11.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jun 2021 11:25:42 -0700 (PDT)
Received: from localhost ([127.0.0.1] helo=jrobl) by jrobl id 1lpazN-0001p4-E5 ; Sun, 06 Jun 2021 03:25:41 +0900
Subject: Re: fanotify: FAN_OPEN_EXEC_PERM stops invoking the commands
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
In-Reply-To: <CAOQ4uxhkDBgC1Sa87vt=DV6mfCoZR-8X5Oc1iqHD6_vVfjv_Ug@mail.gmail.com>
References: <1461.1622909071@jrobl> <CAOQ4uxhkDBgC1Sa87vt=DV6mfCoZR-8X5Oc1iqHD6_vVfjv_Ug@mail.gmail.com>
From:   hooanon05g@gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7008.1622917541.1@jrobl>
Date:   Sun, 06 Jun 2021 03:25:41 +0900
Message-ID: <7009.1622917541@jrobl>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Amir Goldstein:
> fanotify_fd is writable regardless of the argument event_f_flags of
> fanotify_init(). See fanotify_init(2) man page and example in fanotify(7).

Ah, I was misunderstanding the meaning of event_f_flags.
Thanks for clarifying.


J. R. Okajima
