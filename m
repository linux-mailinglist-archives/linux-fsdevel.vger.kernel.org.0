Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38E6576510E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 12:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234113AbjG0K1C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 06:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234164AbjG0K0g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 06:26:36 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2251B30C7
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 03:25:46 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f954d7309fso955960e87.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 03:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1690453545; x=1691058345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4eo0nUNLDSH01XaEhi0ZXVn6hqceUGX3Bt7xyegC/Sc=;
        b=AHFnzs/q47CXYaHIVWpF7M9ENsWBNsK8UIT0U5PJtm0+RF4XCnQrVtk5oZYdHkEWIO
         +tnH2OTlCMSUN9j2MhgNmyd99SjGNZJKfISm0+t4tbTjQwO7ozOjMOKw5oZqGJEnGFK6
         RmdYZg4YzYsBiNVLqbuwoQbpo/88yOrzlejrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690453545; x=1691058345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4eo0nUNLDSH01XaEhi0ZXVn6hqceUGX3Bt7xyegC/Sc=;
        b=G6eYT6BhpCLKKcgV72vvsocjHapozm0Z0pFSjXwkoK0JaoEPgwg7l3C14ZqWS/a1au
         ajWkw7DwBmKALvMhgb4e+cBRnzQ5AL6kIXj1n+eMUCYAPvu+FN7pc/FO97fbA1+VoKzB
         FwttnXXZKb5ue9pOfj7u3sGlq+wSXqQSXZzN6feI7qKD1x40PwD4yWYFXwJZ1hgOtkob
         35xwXLPZ7I3WmI41j9AMDOQ4/TrtFojwiJuujfwgCRYObBSv9Fz/aYIn27fd+Q5bV+19
         qKqdbc3XiqceKUn8kO3BRC2w+V4sK2T+3vTD6QI/ywio+DQi0qv+jgJP7RVFSEAAjXF7
         OCKQ==
X-Gm-Message-State: ABy/qLbngnlAAqEuuBI2StqTOxjwe0YwnsbGysgD5sUKgL0N56KJl7Pj
        LXcoiHraAO9w7yQ33Iy0nQITv6t6KcOrw1N2FcOAlQ==
X-Google-Smtp-Source: APBJJlEYQigitByUZfSadIsB0MkvvnGp/ZJ98N872TQtA/Nc4bVV3uhL6gODz4sBFjYOZvXykvIg0tATyBeZFT5gp7s=
X-Received: by 2002:a05:6512:2824:b0:4fe:17a8:bee5 with SMTP id
 cf36-20020a056512282400b004fe17a8bee5mr703651lfb.31.1690453545006; Thu, 27
 Jul 2023 03:25:45 -0700 (PDT)
MIME-Version: 1.0
References: <CA+wXwBRGab3UqbLqsr8xG=ZL2u9bgyDNNea4RGfTDjqB=J3geQ@mail.gmail.com>
 <ZMHkLA+r2K6hKsr5@casper.infradead.org>
In-Reply-To: <ZMHkLA+r2K6hKsr5@casper.infradead.org>
From:   Daniel Dao <dqminh@cloudflare.com>
Date:   Thu, 27 Jul 2023 11:25:33 +0100
Message-ID: <CA+wXwBQur9DU7mVa961KWpL+cn1BNeZbU+oja+SKMHhEo1D0-g@mail.gmail.com>
Subject: Re: Kernel NULL pointer deref and data corruptions with xfs on 6.1
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
        kernel-team <kernel-team@cloudflare.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, djwong@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 27, 2023 at 4:27=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Fri, Jul 21, 2023 at 11:49:04AM +0100, Daniel Dao wrote:
> > We do not have a reproducer yet, but we now have more debugging data
> > which hopefully
> > should help narrow this down. Details as followed:
> >
> > 1. Kernel NULL pointer deferencences in __filemap_get_folio
> >
> > This happened on a few different hosts, with a few different repeated a=
ddresses.
> > The addresses are 0000000000000036, 0000000000000076,
> > 00000000000000f6. This looks
> > like the xarray is corrupted and we were trying to do some work on a
> > sibling entry.
>
> I think I have a fix for this one.  Please try the attached.

For some reason I do not see the attached patch. Can you resend it, or
is it the same
one as in https://bugzilla.kernel.org/show_bug.cgi?id=3D216646#c31 ?
