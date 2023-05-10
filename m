Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38B426FE276
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 May 2023 18:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjEJQ1s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 May 2023 12:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbjEJQ1R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 May 2023 12:27:17 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E00FB7DAD
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 May 2023 09:27:05 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-b9a6869dd3cso9681966276.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 May 2023 09:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683736025; x=1686328025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kYLHe0MguGbZ/ADgF6A2DxPY+H6Bm/j9xdEx/tclVi8=;
        b=C+Ni/k+LpOjV/rKV286XOtS+lqQ2KTQy0sriwAQzCxyzi647oR2KdIIhMG1tyeN2x5
         AE32iSxkYdSyIE5C1Romz0cWbXTeyqKpud1zVgkomgPatc7Wt9XcLwSAtGDpKQSrs4qj
         1lTm/2XFZrkbzoGFzxb5idzrBMBgUPkBFJOtVDNTKnRw7w6g5iNiGmgtZ/QgXy0LWXqy
         HSCkJSyh/AafE1jcQO9XL5pcEy/Q94zIuB5i549buavw6ZNOHXpDV/YUqGK8uOrddY8i
         ukKvwkb8Kr6YWuE1LAHR6rr4aVLkRZ6BOzy083pU99e7NxsNQ+2WZ9rL9t0CZC0gD3uD
         ej/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683736025; x=1686328025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kYLHe0MguGbZ/ADgF6A2DxPY+H6Bm/j9xdEx/tclVi8=;
        b=UPJ9qCkOUs4y2MQBG45lIBxzsxz88GSzLO4EjsBasJIkT2UeyzJoFFs29XoimzmaIZ
         JBh7MBajoyNKx56Zo4Pzk8KumolzsZ4f1Fl3xhlVhkf10oLsb13oLMtRxxu+w4a3ni6a
         QLKV8TE4/UUOCr4iw1VyN0g4db9WhuoFG5njiI/bRW307GM6wrpNe5iBdmodbS7kJ33d
         LDux4R0kpGywWLloW9DpPW3Mv7hPlz+lmuWL3Yjq8xsVEnyZqYW9IUiCSV86n8t02Gd+
         HgH0XVgKlfS5qjdpdJon5/aIWld5XlYAEcTCp4itZEDg6qDV3ec6iVlFjQaoS0f8h4SC
         I/Iw==
X-Gm-Message-State: AC+VfDyqUaMkMNm+mjq/YUtiWGB5+WFeQ+9v+3UNT8Dj6g7EmTogN91O
        OH2gS1F88Pb5uFlfwhtdlJk0u0Y8t1Onp7awmlK/G3SVVL2DzDkCnKklwNC9
X-Google-Smtp-Source: ACHHUZ6HAdo9O0ZGCzueiaqrT+zOj2it6YgxWH68vI5uv3itc/DMdIcKhmu6Ne5taaKdqb11qr+zdJYrZnrt5M0d36E=
X-Received: by 2002:a25:4884:0:b0:b9d:fe06:1f5b with SMTP id
 v126-20020a254884000000b00b9dfe061f5bmr17485054yba.15.1683736024870; Wed, 10
 May 2023 09:27:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAJuCfpHJX8zeQY6t5rrKps6GxbadRZBE+Pzk21wHfqZC8PFVCA@mail.gmail.com>
In-Reply-To: <CAJuCfpHJX8zeQY6t5rrKps6GxbadRZBE+Pzk21wHfqZC8PFVCA@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 10 May 2023 09:26:53 -0700
Message-ID: <CAJuCfpFxei1ZhEZKXQ-AnddU=dmxCsfDLsFdJcxA=3HAifSPcg@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Memory profiling using code tagging
To:     lsf-pc@lists.linux-foundation.org
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Kent Overstreet <kent.overstreet@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 22, 2023 at 11:31=E2=80=AFAM Suren Baghdasaryan <surenb@google.=
com> wrote:
>
> We would like to continue the discussion about code tagging use for
> memory allocation profiling. The code tagging framework [1] and its
> applications were posted as an RFC [2] and discussed at LPC 2022. It
> has many applications proposed in the RFC but we would like to focus
> on its application for memory profiling. It can be used as a
> low-overhead solution to track memory leaks, rank memory consumers by
> the amount of memory they use, identify memory allocation hot paths
> and possible other use cases.
> Kent Overstreet and I worked on simplifying the solution, minimizing
> the overhead and implementing features requested during RFC review.
>
> Kent Overstreet, Michal Hocko, Johannes Weiner, Matthew Wilcox, Andrew
> Morton, David Hildenbrand, Vlastimil Babka, Roman Gushchin would be
> good participants.
>
> [1] https://lwn.net/Articles/906660/
> [2] https://lore.kernel.org/all/20220830214919.53220-1-surenb@google.com/

Sharing the slides here:
https://drive.google.com/file/d/1dBjYgk03hvaVAe7ph0Sad-zfr4Gw4irQ/view?usp=
=3Dsharing
