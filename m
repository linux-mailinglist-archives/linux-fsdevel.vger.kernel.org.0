Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3658E50A9AF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Apr 2022 22:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392184AbiDUUIS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Apr 2022 16:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387130AbiDUUIR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Apr 2022 16:08:17 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F514C430
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Apr 2022 13:05:27 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id bn33so7074055ljb.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Apr 2022 13:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=NwdH8+rjRDlxFy4vl9CTk6e7tYB9OyxwRDgNSZG6Y1w=;
        b=YrT0DkychC77xvw7gJZXCDCRRTcc+xmzapsBzZPiAAvGHZjAj+/Hrm64XP2N6QsLr0
         XbKrROYW1QSRx+7LLCG+PxohFfhZ6HQV2dN9+wn2CLFyBAudL9tE71yhW2eWUA/K/6cf
         9zAm6A5EYu46D5Oy3mwRB7TR0oeT56u0pxmHcJMpIKS5bsgTznedVjJqTF/nBGVYraSi
         ya9nDYtzOmQ1JpgO4DPW7h4xYv7CqD7apDc7Vq/jTPG7NWqGeFnMT0V5LMW53snRHg+P
         fgpWvcRZuqj4EB+V0pr1z468mJSN/gz51J4KciBvatX1FTaw+cayrBkdaQSRCMIg4Xpf
         13lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=NwdH8+rjRDlxFy4vl9CTk6e7tYB9OyxwRDgNSZG6Y1w=;
        b=GUoYmVaNnLTu5EXiOD3RuFpKDJUr8kCRXivPLQCX2rx/g+ebtK0scSZWp2Kl2mSzxV
         Q8OHnh51hGlZ9njSWlarqoneVDltk+aq1VBCKJBIPnhapOjz07EcPj48YVUUvDbsiHvZ
         mFpv/nIiU9/aq/0DBSkpuTwZcovkNic6jLxt+VBbUbealTOt61c1OXZXW65dM3OaztUP
         fwsN4KksxI8l9ml3AUQAlhlJSbJc2J7PfApn5WTcBEDUSwy5eIh7GcuUu8x//GkzET6+
         RCKDOJ81LCwlou5apDdicUKHlEJPsck4+uLCAuVpYnVtT0BJUbiVRMMa7bl7qUOkFSF/
         T24w==
X-Gm-Message-State: AOAM532FQbVJgAbCllRHMalF7yYPL6snhM5lZnauEYrfY1vPYSEJXsRf
        Xu1wjSmtUdj+i4S2dzN3au6tC1eqUghA860kOJEErkai8vZGZQ==
X-Google-Smtp-Source: ABdhPJxShZhUS+HQK07Jssgwyjgayzn2Kw8PyjOvVwaF124XPAVE/3x+jxQezOz2M00QTV9JWYmYp9lw4IN4dUYnU74=
X-Received: by 2002:a2e:888c:0:b0:24d:ba94:260c with SMTP id
 k12-20020a2e888c000000b0024dba94260cmr748648lji.403.1650571525324; Thu, 21
 Apr 2022 13:05:25 -0700 (PDT)
MIME-Version: 1.0
From:   Lan Sijie <sijielan@gmail.com>
Date:   Thu, 21 Apr 2022 16:05:14 -0400
Message-ID: <CAGAHmYBpipWnVaqBsLLXUYE-BdusGg=qZAHno9OE2hkzitOxUQ@mail.gmail.com>
Subject: throughput on F2FS
To:     linux-f2fs-devel@lists.sourceforge.net
Cc:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

HI, team,
When we run fio random-write test with 1,4,16 threads on compression
f2fs, the throughputs on different threads are roughly equal, we
expected that the throughput would be increased with more threads, but
it isn't.
So we are wondering if anything we ignored?
