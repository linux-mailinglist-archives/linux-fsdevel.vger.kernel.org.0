Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC43C54F20B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jun 2022 09:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380571AbiFQHg1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jun 2022 03:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380468AbiFQHgZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jun 2022 03:36:25 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E0366FAB
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jun 2022 00:36:22 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id y19so7149961ejq.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jun 2022 00:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lFSvXWnMhV0ta+uOardT419nO7q6Hq5t2QYuh46TUv4=;
        b=Qhai7TiOMAImwxaojs6g3DzfizpP400kQjj8YnEIFYKPoCiq9tH26r2InFHJYazbAe
         2oUD5p1gCgYD90nQMBltPqFO8vSZJpa0QS8TdcCLl5gCsPhDyIliBidIxA4v+yMC7nDa
         omc1Sj/QY/mrcAB6OAcCPHxzhRX76dsnKSbRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lFSvXWnMhV0ta+uOardT419nO7q6Hq5t2QYuh46TUv4=;
        b=1fp0P7ARQjXl4kv0aNiQeDolI7f2kqZcAEuET9me3Z9YuMzPkZ2numLTYc7TzmdVXP
         i6C+niojvtZTbxsJYVB6iuJbfG7HlizW9Oav2PwjAdFna3LnJS2WRZfEL0QTzTUAG2oY
         GOMGFkGdmyMRCTf0BPzTiFuCHB4SbqaGdRStfQlJEGoBWFunkUITipR74oz2/OibvOxf
         lDLlCqMiruPWtfc84SlwnaQwwzXDNNCqsxwsh0FaQmabi0viwANkU05yGgUa/1KRWknh
         I6D3JkNQqppnjMZYkhnyxxkPj/oC/7yr1GHx+qn7cWD20axMvcVD6tFT+QWon9fLb6XM
         f98w==
X-Gm-Message-State: AJIora+OsUNoVZIuemL6uSMjDFQayY1lMpA1yh4EjPr4mVwQaYunpWoe
        14YPdXCPW/9quwWT0UGKeNAeMphmN12bzWhHMyHl1A==
X-Google-Smtp-Source: AGRyM1sERXFFpBnekMT3mnfespNrQpWUCBUpQ9UlcR5Dk5VAfBFoM/6wYxONe8v6LCIYyG2jO7xBoNvAEx0S9+oPo5s=
X-Received: by 2002:a17:906:b788:b0:711:fc54:e55e with SMTP id
 dt8-20020a170906b78800b00711fc54e55emr7843526ejb.270.1655451381149; Fri, 17
 Jun 2022 00:36:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220617071027.6569-1-dharamhans87@gmail.com> <20220617071027.6569-2-dharamhans87@gmail.com>
In-Reply-To: <20220617071027.6569-2-dharamhans87@gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 17 Jun 2022 09:36:10 +0200
Message-ID: <CAJfpegtRzDbcayn7MYKpgO1MBFeBihyfRB402JHtJkbXg1dvLg@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] Allow non-extending parallel direct writes on the
 same file.
To:     Dharmendra Singh <dharamhans87@gmail.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>, linux-fsdevel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org, Bernd Schubert <bschubert@ddn.com>,
        Dharmendra Singh <dsingh@ddn.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 17 Jun 2022 at 09:10, Dharmendra Singh <dharamhans87@gmail.com> wrote:

> This patch relaxes the exclusive lock for direct non-extending writes
> only. File size extending writes might not need the lock either,
> but we are not entirely sure if there is a risk to introduce any
> kind of regression. Furthermore, benchmarking with fio does not
> show a difference between patch versions that take on file size
> extension a) an exclusive lock and b) a shared lock.

I'm okay with this, but ISTR Bernd noted a real-life scenario where
this is not sufficient.  Maybe that should be mentioned in the patch
header?

Thanks,
Miklos
