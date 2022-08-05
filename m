Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA6858B000
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Aug 2022 20:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241348AbiHESqg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Aug 2022 14:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234104AbiHESqf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Aug 2022 14:46:35 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2FC018B3B;
        Fri,  5 Aug 2022 11:46:33 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id o14so1778817ilt.2;
        Fri, 05 Aug 2022 11:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7pB3CUQguyZpocpsTCxrp+VM0mZPpD9HY2PyAfQxq3M=;
        b=mqiqdp7VfmwVU+HdUvUa2IwML+0sE9i/8IuuQgkbYZa2RejZDdLMQ4sTKXZM3SvqMj
         KW0zqiicDNvIxcldubT0YJkivYkhh1KrJC04unspffI0ZJD1InS4aikxbd9YeJwMh/N5
         O1D09cTluvjPnizIEVxZrGYtMtKsdtHxMEb8Thr4kfS7PHRO3oPz4JmxHJOlHlKVdK7I
         WFQRD4jUI6yUFW2ZNBb4YvtjoetLuk4SrIg5XpBoInTz6r76hUGhnQB0Z/l6+YE1h3zE
         NAqM0icbnGgaJiuAh1T0DclODtnldWro3bxqMWFkfpGEBzd9U5+iqhWr7xSNOyDiKNre
         k6yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7pB3CUQguyZpocpsTCxrp+VM0mZPpD9HY2PyAfQxq3M=;
        b=FuuQyd5t966CLLOlqI0jXwl6fHOoz5W7/br6wFpF7YVmXH1k+bY45Gss4SYohsiRyU
         gKIlRoCcsI7oiQeU+8S1QiyIU7+9VDJmr3aHh4u9atISV5yYjbFeupwxVwV2IDnQz516
         8znyHbs1dciAbVcJJJaeaFb8xvUt67wGn/dVPiJZToe6fXI72l4s3/R2bYVxkRI1iq/H
         L7WoQa5P5hkPghqyIYGyWUb7MslWqKQ3yC0YUdgiL4LLE06IZKRD75SlIrD4d2cTUBNN
         Adfjq8o6v7Tvmn1S7yjwBO0JC5b/+Ou3UuSyVqfUIWB9G+IundXclZo84w0XxKybpfa6
         3FXg==
X-Gm-Message-State: ACgBeo1DZz/ExuVkKwMKKR6EZkVuK75bgzgfTot5LNedbr/3e0lrtBRy
        fc126d8uR7rReEX6NxayczEQBrcCMS+4Gt+MRn7wDuGgWooZuw==
X-Google-Smtp-Source: AA6agR4YDYzXkvB7rHVbmM/Rp4RI4JkQJPt89N4l1KoM+JTZ+0Y9PTuGAO0CISMINEm7dCPE6TaMq7XLJwhWouw1hCU=
X-Received: by 2002:a05:6e02:1c23:b0:2dc:e497:8b12 with SMTP id
 m3-20020a056e021c2300b002dce4978b12mr3659739ilh.151.1659725193408; Fri, 05
 Aug 2022 11:46:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220805154231.31257-1-ojeda@kernel.org> <20220805154231.31257-2-ojeda@kernel.org>
 <20220805164834.4xq7hm6ee6ywjpjo@gpm.stappers.nl>
In-Reply-To: <20220805164834.4xq7hm6ee6ywjpjo@gpm.stappers.nl>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 5 Aug 2022 20:46:22 +0200
Message-ID: <CANiq72mXDne_WkUCo2oRe+sip7nQWESnouOJrcCYzyJMkG8F6A@mail.gmail.com>
Subject: Re: [PATCH v9 01/27] kallsyms: use `sizeof` instead of hardcoded size
To:     Geert Stappers <stappers@stappers.nl>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
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

On Fri, Aug 5, 2022 at 6:48 PM Geert Stappers <stappers@stappers.nl> wrote:
>
> Signed-off-by: Geert Stappers <stappers@stappers.nl>

Thanks for the message and the support, but please note that since you
are not in the path of the patch, you cannot use this tag; instead
look into Reviewed-by etc. See
https://www.kernel.org/doc/html/v5.19/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by
and the following section for details.

> And I think that this patch and all other "rust" kallsyms patches
> allready should have been accepted in the v3 or v5 series.

Yeah, it could be a good idea to get the prerequisites in first. Let's
see if the patches get some Reviewed-bys (e.g. I had to remove Kees'
one because I had to split the patch).

Cheers,
Miguel
