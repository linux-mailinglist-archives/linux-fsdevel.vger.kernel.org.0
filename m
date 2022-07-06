Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0805683DD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Jul 2022 11:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233249AbiGFJkx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Jul 2022 05:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233250AbiGFJkT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Jul 2022 05:40:19 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE2E25E8E
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Jul 2022 02:39:16 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id bk26so6130472wrb.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Jul 2022 02:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ErGLk8+0xCu5WgLQ3bfjqxCtN8t8ZPaM8b1famx/Fhc=;
        b=NISUS53ui9lqHhMNJqxRViQAmHoCdqL2kl3dzcfsZmvR18jOqIZkYtwHGH6371s6Zr
         SG/9nWcyU53biytlJ7pXpgOXd8AehqfqD0aZeLzlsZcSbIn4PNwl8/6+HBXGlh4OxKvE
         76v+7HdnNyLVl66N80XQQoB4iw/kdBo7RQNgT8B+e7Ydq5jumaKh3PAzzPKO7TBoW8gM
         1BYr8bZweqgS5F8uBNraXwcEvg6CNL14/93mGxIL2sreRbLYDeB0Q/lhpWZ9mcCuMBrp
         DQkTRCYrG/TF74OGdXob3+G/GaMAyu5njiYed9G4v40fWB6+3r+yPwKYyZ0kuxuHe5Zl
         MOdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ErGLk8+0xCu5WgLQ3bfjqxCtN8t8ZPaM8b1famx/Fhc=;
        b=GCWADV7oQTtJk9r0jrbsUo0snmpg907joeOCh3Jf5gtQESpnznU1i/w+DcJF6sJuiK
         eZYSzp4DNrkjl0nvLz4n/Xy1VqLkTtQePn0+2IXotLbyw+q1IQnXuPjdsetXpxyyIORZ
         wX9GqSXJfEVLqFI4JPUQ1DHV2ug2s4DOh4DM4YqBeHAsOSJbTad9jRAZaeKUz9Jye5NA
         7uhmkkXa9MYc5CoH9q4hvv/fvTgUkYBYBDc3yMcsPk4VRDbXZnhFykNP8XzOxE16wbrh
         jCkpWicQw9oimembAEBYbTM+Re4q2LcBqZpoYoKLow1F55SEvCJWQVDv8bH7lTqS3kFV
         PDkw==
X-Gm-Message-State: AJIora8jrdF/f1h52eYtv5ybmHgcrGqrH4V3Ax92eJCI8ST/Ob+ZEEgH
        mr54zk0IQejAP6mBhA6g/lODaQ==
X-Google-Smtp-Source: AGRyM1ufXZJBseWnCkHVYra95dQ8hroZ4IoSqEvEkNuJeGFsBw2JN6YWKeUBiI5yI2af5FOZlag4mg==
X-Received: by 2002:adf:dc0d:0:b0:21d:ea5:710f with SMTP id t13-20020adfdc0d000000b0021d0ea5710fmr36516555wri.48.1657100354526;
        Wed, 06 Jul 2022 02:39:14 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id k6-20020a5d6286000000b0021d6e14a9ccsm6036070wru.16.2022.07.06.02.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 02:39:14 -0700 (PDT)
Date:   Wed, 6 Jul 2022 10:39:12 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Haimin Zhang <tcs.kernel@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Haimin Zhang <tcs_kernel@tencent.com>,
        TCS Robot <tcs_robot@tencent.com>
Subject: Re: [PATCH v2] fs/pipe: Deinitialize the watch_queue when pipe is
 freed
Message-ID: <YsVYQAQ8ylvMQtR2@google.com>
References: <20220509131726.59664-1-tcs.kernel@gmail.com>
 <Ynl+kUGRYaovLc8q@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Ynl+kUGRYaovLc8q@sol.localdomain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 09 May 2022, Eric Biggers wrote:

> On Mon, May 09, 2022 at 09:17:26PM +0800, Haimin Zhang wrote:
> > From: Haimin Zhang <tcs_kernel@tencent.com>
> > 
> > Add a new function call to deinitialize the watch_queue of a freed pipe.
> > When a pipe node is freed, it doesn't make pipe->watch_queue->pipe null.
> > Later when function post_one_notification is called, it will use this
> > field, but it has been freed and watch_queue->pipe is a dangling pointer.
> > It makes a uaf issue.
> > Check wqueu->defunct before pipe check since pipe becomes invalid once all
> > watch queues were cleared.
> > 
> > Reported-by: TCS Robot <tcs_robot@tencent.com>
> > Signed-off-by: Haimin Zhang <tcs_kernel@tencent.com>
> 
> Is this fixing something?  If so it should have a "Fixes" tag.

It sure is.

Haimin, are you planning a v3?

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
