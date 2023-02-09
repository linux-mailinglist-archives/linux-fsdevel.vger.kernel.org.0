Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72AE669117E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Feb 2023 20:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbjBITnc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Feb 2023 14:43:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjBITnb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Feb 2023 14:43:31 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC991B547;
        Thu,  9 Feb 2023 11:43:29 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id g14so3327129ljh.10;
        Thu, 09 Feb 2023 11:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lKrvt3Yk0Vf+Ic9r8CXuKSJLUhLzWZxqJeVMmv1IIDU=;
        b=f+4j4upJwTDcgIayq3/ARXO0BDlS/89c+M3t4WARqGagMC0mlvot/wkDtxH5NXbJjQ
         ZIPK6whW8G1ky3/L6WUbk0otgTFBYuQ08YU8mIiVE5kb2gqXlAkECDy0ZLOniUUEMQTD
         TBJifxskYTCXQ8rg7NS6FG/5kGOCtqmQ2svn0cjOhAgJLhNQvlDdch1WwJNaclj+keQM
         rpHaDVz7Q7j7Um8JYBtNgFw467T8oUa+LQ0wk8NHdjVEI3Daas7m/7EdZGYpqVKbmhFA
         GYxW7WSSzUxYbqC1vm+LHhWupCaAT7ncsicwb7qQDCsnINKlPGryWVvg0PSCOWEL2cSg
         wqCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lKrvt3Yk0Vf+Ic9r8CXuKSJLUhLzWZxqJeVMmv1IIDU=;
        b=bxUsZgm6JrJMDkxGpmKUB/iKCsOi55pB3IXISXdhQ0oFeUCDHF2OLtMDa/ookxuYWr
         cJAyg+A/MnL2J+jG0g8zA/9JbZ2eqrYsY+RLbAsNtxqX/zsIeCNvsMLRATFHbWIQCY2F
         Pa/QI8YgbLP0Ik2rZcPxHaPNaEA6fvYlBAsn2ms0FotVQvWtJmVB7I+DKWr+uCOAetf9
         DDeS1TSTkXu86MdJrvlQJcN2DC2UWN+n7fS+trCxoHBEhs2KhpQAiT9PzXWoAGXmqML9
         3TlXke11yQWp34CZkzsWloMB9gDzK4N/+ZGfPDqdGTqcIs2btQPhbH6G3/SiNsRLtTR9
         gz3g==
X-Gm-Message-State: AO0yUKU7HfG0a5fZ7L76neN+lA2TGfVqp7km0m8jgU1IfLF8sv7+aEew
        7sZazK/1CvEI/827ZM45yN5HahMaL/A9feMQhdXAI+Vn
X-Google-Smtp-Source: AK7set8NPbt4zLjxSxEjn3lnWzUR980aoUp2yeVPsSy9jr7aP8gw7opNz83FfiOVEPohFqxxdhRcKEpF3+0/gBn3DBA=
X-Received: by 2002:a2e:8805:0:b0:293:301e:9459 with SMTP id
 x5-20020a2e8805000000b00293301e9459mr613280ljh.203.1675971805978; Thu, 09 Feb
 2023 11:43:25 -0800 (PST)
MIME-Version: 1.0
References: <20230208145611.307706-1-willy@infradead.org>
In-Reply-To: <20230208145611.307706-1-willy@infradead.org>
From:   Steve French <smfrench@gmail.com>
Date:   Thu, 9 Feb 2023 13:43:14 -0600
Message-ID: <CAH2r5mttZxmc2QWWw+DE8V6LrFoicYWXQ4U-u5iX+WGvRoZAhQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] Remove lock_page_killable()
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
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

merged into cifs-2.6.git for-next pending testing

On Wed, Feb 8, 2023 at 9:11 AM Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
>
> Remove the last caller of lock_page_killable() and the API.
>
> Matthew Wilcox (Oracle) (2):
>   cifs: Use a folio in cifs_page_mkwrite()
>   filemap: Remove lock_page_killable()
>
>  fs/cifs/file.c          | 17 ++++++++---------
>  include/linux/pagemap.h | 10 ----------
>  2 files changed, 8 insertions(+), 19 deletions(-)
>
> --
> 2.35.1
>


-- 
Thanks,

Steve
