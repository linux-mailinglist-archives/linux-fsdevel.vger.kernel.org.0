Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F047292EA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 10:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240719AbjFIIWc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 04:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240717AbjFIIWP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 04:22:15 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC1D46B9
        for <linux-fsdevel@vger.kernel.org>; Fri,  9 Jun 2023 01:21:01 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-977d4a1cf0eso230247866b.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Jun 2023 01:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1686298798; x=1688890798;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4IFWYyf7AHG1YK6ToLFBS30KicQHW59OkJcHs5Sk//c=;
        b=A8RUIjrd7LmeCMRHnqHgqqjgdgPoagNoNArGO0MDbg7Tf614h9aPRc23QosJA9hpVC
         GYa3KdWhogLLyNcs2QNFy82IcFJ6AP11GMhdr2Q8funxOgpJc2YlDiR5FMFJ5FTgiBQE
         nhD/TYn3wvrHRpxyxBPqIrGby/4WTp4Fi2VYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686298798; x=1688890798;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4IFWYyf7AHG1YK6ToLFBS30KicQHW59OkJcHs5Sk//c=;
        b=RGSnXGRXBlKOn7MTgoJV1544r4+iwvZXEfAKMNe+vXkCcc2JnuNgwyCNFJxPXqzfZp
         qQFXX6gnsliy1S/YrJ3QK/IhL/RB/CQ9nZAh5S46WSCy+6GUnG2x9R+1GsjxVrX4sEBn
         OCmqIB8kdoOCJIQxMgOAg+Pvyg7bcEW3jlvVgHPg9tNtJLV1AWRBcsGFQ0wTTsvZ//m6
         LoUTMP6aqYi4+MvSAPNxT47xt/Pu5+j4Xi4OEG21vXC9ZB08O26kqQRavOA/34Szojhn
         2ZVV4VyF3Fa9mc6GabsR0fS0OkkHMQJkEdj99U5i4vMvR9P0pP2pW0yWtL/uqSFM10NJ
         JFqA==
X-Gm-Message-State: AC+VfDxIR85xzIYBmiRrW5utap176WMwMnvXXI4fT3xhLyXn3iLAJgNv
        Ng1jQq8+qeiVuoa/HNQyDj8gJ0ExKRF3l6omWG0h7nPWNMhuB/Ax
X-Google-Smtp-Source: ACHHUZ4C2Z8z76TpsaSC5hnjHwoW+WWNnwFyAbHiRGfqvFJs/D5EQBrqmaNY7ZftDRtFoMuU0ynnRRVsVb2mlWsY6uY=
X-Received: by 2002:a17:907:6e1a:b0:974:5d6e:7941 with SMTP id
 sd26-20020a1709076e1a00b009745d6e7941mr969070ejc.6.1686298797776; Fri, 09 Jun
 2023 01:19:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230609073239.957184-1-amir73il@gmail.com> <20230609073239.957184-3-amir73il@gmail.com>
In-Reply-To: <20230609073239.957184-3-amir73il@gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 9 Jun 2023 10:19:46 +0200
Message-ID: <CAJfpegtJ0BHB6k0uK3=175LfL5iTnghxucr3j3sGxoCcm=+a4Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] fs: use file_fake_path() to get path of mapped files
 for display
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Paul Moore <paul@paul-moore.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 9 Jun 2023 at 09:32, Amir Goldstein <amir73il@gmail.com> wrote:
>
> /proc/$pid/maps and /proc/$pid/exe contain display paths of mapped file.
> audot and tomoyo also log the display path of the mapped exec file.

/proc/PID/exe is based on task->mm->exe_file.  AFAICS this will be the
overlay file not the realfile, so it shouldn't need any special
treatment.

Same for tomoyo.

Maybe I'm missing something?

Thanks,
Miklos
