Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 236042A4FB7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 20:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729551AbgKCTHv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 14:07:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727688AbgKCTHv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 14:07:51 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE07C0613D1
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Nov 2020 11:07:49 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id f9so23722111lfq.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Nov 2020 11:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rKUHzsviEuokxUGu22QFHyaH3lLKMM46sQ9d27q6DnY=;
        b=EzdzLMp/DLlOuVI3UfWBZa3MF6YmJiHzlplfPPXBVMASkRf9Sf9vzP9/wDbjlH37K7
         FUzOZepTJ9Zk8DxHsS++APrkxbxeHOgKk4I+HPOv2lXAogfFlbdAQ2lzXt3Bq5svOW47
         5eCW6xfTvMI+6aKzHBA0ba2616JChJCv8upyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rKUHzsviEuokxUGu22QFHyaH3lLKMM46sQ9d27q6DnY=;
        b=E9gEhhe5nf9EcTpktA+58Ad9by8UwPbu39m8lLbbC4IDDIf62f6X11qCsF3PJDj84d
         kwLjqSUQsdM27pfY0uoIvVLSQiu4l46/GQOqu6DBhL0ZmLzFrwKw+rb3iNp8ypv61NPO
         tt94y4cOS+ik47y6FXw47ouNWWs43xSQRZVC6dOvOA4Ih5DqZgtkq91PukRN0nOt/27p
         ORuLzjkoIKm0f3+n3ps/YMsld9Pc0ehYE1HOzd7VXowzAYOGf2F1gbrW3QWpIc9Lfb16
         7kn+RrHuXimpK0YHIuCvex3QrJhdGJ/RnzJJviqHfQowCM6KN34Df3nrbwWbuGHUBfrr
         VWmQ==
X-Gm-Message-State: AOAM532GwFQWpNIDtSx17FxBlRdEueduQYNiefqX6kEUR1MqU+FcxRgq
        TduLmpRqrebo2J0V1pcdj288L8J5YE+c9A==
X-Google-Smtp-Source: ABdhPJzMIwXgQFAPnu4s9UE9g5ZY+jNCDBH/6oRVuXZZWg3L9Ph8jthnnVKdFTIlgNK3ZECVnnft1A==
X-Received: by 2002:ac2:5f4a:: with SMTP id 10mr7964170lfz.395.1604430467710;
        Tue, 03 Nov 2020 11:07:47 -0800 (PST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id k3sm3193878lfd.245.2020.11.03.11.07.46
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2020 11:07:46 -0800 (PST)
Received: by mail-lj1-f179.google.com with SMTP id o13so11952487ljj.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Nov 2020 11:07:46 -0800 (PST)
X-Received: by 2002:a2e:87d2:: with SMTP id v18mr8682395ljj.371.1604430465892;
 Tue, 03 Nov 2020 11:07:45 -0800 (PST)
MIME-Version: 1.0
References: <20201029100950.46668-1-hch@lst.de> <20201103184815.GA24136@lst.de>
 <CAHk-=wha+F9-my8=3KO7TNJ7r-fVobMrXRdUuSs5c2bbqk1edA@mail.gmail.com> <20201103190253.GA24382@lst.de>
In-Reply-To: <20201103190253.GA24382@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 3 Nov 2020 11:07:30 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjvkBYOq0-xRH1YGXn4imB2iDVN1wEZisMcQd7dPeNbuw@mail.gmail.com>
Message-ID: <CAHk-=wjvkBYOq0-xRH1YGXn4imB2iDVN1wEZisMcQd7dPeNbuw@mail.gmail.com>
Subject: Re: support splice reads on seq_file based procfs files
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Greg KH <gregkh@linuxfoundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 3, 2020 at 11:02 AM Christoph Hellwig <hch@lst.de> wrote:
>
> > IOW, I'd start with just cpuinfo_proc_ops, proc_seq_ops,
> > proc_single_ops, and stat_proc_ops.
>
> I think Greg reported another test case hitting /proc/version

Yeah, that would be covered by that proc_single_ops case.

Those four cases should really handle all of the normal /proc seq ops.
Anything else is going to be something very special.

               Linus
