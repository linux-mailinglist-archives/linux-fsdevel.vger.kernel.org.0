Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1742A306B91
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 04:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbhA1DY5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jan 2021 22:24:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbhA1DY4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jan 2021 22:24:56 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3A2C061573;
        Wed, 27 Jan 2021 19:24:16 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id a109so3930762otc.1;
        Wed, 27 Jan 2021 19:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OYYp98emCYbezQq/m91klUFEwQ6HOz/V/2yrmLptqo4=;
        b=sTbRz3Fp8BxbEGcPcXFbGFBNj0QyTWronVAx9s45RhvLqwqMYvEgkeyYflthoHozF+
         aZYjJLzGDBKwwINye9XlLR+l8gkcn2xrHsegUFrL/3h92NSeuIIoWr2dC3EB/Yt3zFty
         Z6GhSRbAFDclKAbXik8guHiDYlduBdUjwkc7Zyn56n2yl3BGNTFldY2qMUzqNKAgZCAE
         zZZhuBGo9Ycp6pjDd9AOcEIMx0HlUPhkAq3PE7XvobdWM3t1R7Mh9lFjmvRYAC+vI2YB
         Y6ovslDTqG29U8Sf3Fw3NMht4PGl93juTer8P+o3hTe3uimKxFBGlRQ3Sl1BZ/zDwETt
         3sWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OYYp98emCYbezQq/m91klUFEwQ6HOz/V/2yrmLptqo4=;
        b=PaYfmO5HmisjfCRTp2aUvDOPzSWeQaPm5ZD+dBvL/t0EqvLQsHBJLM13osEP0ylqON
         e2QxKtzLxgCl5WjMhG30L4SQlIz7nt4wQUQ5yPgjhtrbp4XMQH0f+Tn7X8PgCS0uzUE1
         ncLYXU+3F3sVyJnVXd1hJoYqIFpdWErJsaq4u3LQMjG1aKxTCXQSIRPHSqHUrKOAq4Sr
         eciHFc1xEwE2gtufeSmMcYQQA/GpAj1ULRgH6hjb5WXjpXOgTYnzfM+ja5dwZqLqychd
         vepbs+Rmp/cLZLMAFsZ6aKwtwgr8H3kAQXz3uwPO7zOXyw6eAm2x6dxcvDobx8tBEwch
         Hb3w==
X-Gm-Message-State: AOAM533wzGHR2J8fhQ++q0AQbs4ij2AHourURagfxchfazY3sJdBcWNn
        fEKojf3tEzkJB4GCfxQsXqxaIPFG7XnzysirCMN3J5umat0=
X-Google-Smtp-Source: ABdhPJyih9clxYo3kyGEyOQlrM1HWyH/2TRK4/OfMvA0o4ba/0wzoe2/UGo+qcT/FX27QsrzX+QfukXrDhFBwtVvXwo=
X-Received: by 2002:a9d:1421:: with SMTP id h30mr10327853oth.45.1611804255820;
 Wed, 27 Jan 2021 19:24:15 -0800 (PST)
MIME-Version: 1.0
References: <20210115181819.34732-1-ebiggers@kernel.org> <20210115181819.34732-3-ebiggers@kernel.org>
In-Reply-To: <20210115181819.34732-3-ebiggers@kernel.org>
From:   Amy Parker <enbyamy@gmail.com>
Date:   Wed, 27 Jan 2021 19:24:05 -0800
Message-ID: <CAE1WUT7v4PTu2hEgDSpj+Y3f_Hn0XzOH3kO1-eYkOUgNun_9DA@mail.gmail.com>
Subject: Re: [PATCH 2/6] fs-verity: don't pass whole descriptor to fsverity_verify_signature()
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net, linux-api@vger.kernel.org,
        "Theodore Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Victor Hsieh <victorhsieh@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 15, 2021 at 10:22 AM Eric Biggers <ebiggers@kernel.org> wrote:
>
> From: Eric Biggers <ebiggers@google.com>
>
> Now that fsverity_get_descriptor() validates the sig_size field,
> fsverity_verify_signature() doesn't need to do it.
>
> Just change the prototype of fsverity_verify_signature() to take the
> signature directly rather than take a fsverity_descriptor.
>
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Reviewed-by: Amy Parker <enbyamy@gmail.com>
