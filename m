Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 745A059527B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Aug 2022 08:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbiHPGZv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Aug 2022 02:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiHPGZg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Aug 2022 02:25:36 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 896EA183E25
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Aug 2022 17:31:20 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-11ba6e79dd1so4880379fac.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Aug 2022 17:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=sjHa9icqRlJ0JksO3F6ZvE7i15gfikQ5o3Vy7JFxppE=;
        b=h0YbD3es2uiuXm+iZMywYsWMiom4/q54qBleqHYw3O9z1DwQ1PDlGF7Oyud718lg1x
         v39v3Ab3qyz/iA8AwkK9PidS3HjQqrJLfMvtJobFOkfLKkYQp8LgYozNCFwKGTgWzHV6
         AU4FLhPWOZnSok4kEb/PWbb9inD8DI/xUupOvz+CO+iQMAQsqVvdyLd58vbCGY2aHGGl
         ijXXD3GpqM2Z7MgXjowUbLaAvK8lhnjeEBWxfx/MYLlQnYEJNqEw9wqhzl9S7bEvgjXa
         AdfC04QQAFuTXNxf5uQWCVF4h8ix74FubFDHSZ5Q7SHRJ6mqpL+dnF17CUYYUn8Gs5zG
         fskg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=sjHa9icqRlJ0JksO3F6ZvE7i15gfikQ5o3Vy7JFxppE=;
        b=lfyJ53s3Uo2Q9Yp+LsR8x6zsHdieUcFlWEVxpWcfTvUTeZBqgxbTcTHY0JiFIw3dOu
         7HTae8v/V4i3roAeMqap7OjgWKqG3Lrm+VrJcWbqpTuOZ3IItdcoRXUquVPl8WcrXIrP
         B1HzrGzDo9sRszEjQO/pT4jc/8frtBVQ0FDL3Y/+T/Ci6qNF0sEZ97usi1dl9TqvnU2u
         TrSKAkB94KWV0+7bsCsamHLuy9pU91LrCXQbi8HSp3ZIWmgTAlkZ7DlM5PrNGrXI+c8r
         ZuKTHMHZfai9dPsKaLuTicDl+Jx8y+7M34fUU51zRKI5DRX2nUVF1hLiDLFBTxCt1YPl
         smgg==
X-Gm-Message-State: ACgBeo12AAZ/MRp1FN55Jw+TX5MEXeblX2Z3R6nvKIHYj0U5rRjmDue5
        F6GhdZ+HdSSUJVvq3/J2yZM7SwfSuC8QEzJQvf44
X-Google-Smtp-Source: AA6agR41whzPOTaUXB+gAEEw9HlVd4Fqc0u91wOZVxmy2wI70Rmkkyj4tbRzAUD7nn3ppYKyaYWLu9psp1gGsRe7Mvo=
X-Received: by 2002:a05:6870:b41e:b0:116:5dc7:192a with SMTP id
 x30-20020a056870b41e00b001165dc7192amr8115012oap.136.1660609879901; Mon, 15
 Aug 2022 17:31:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1659996830.git.rgb@redhat.com> <2d8159cec4392029dabfc39b55ac5fbd0faa9fbd.1659996830.git.rgb@redhat.com>
In-Reply-To: <2d8159cec4392029dabfc39b55ac5fbd0faa9fbd.1659996830.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 15 Aug 2022 20:31:09 -0400
Message-ID: <CAHC9VhQYDsjx2QVRqU8NUr2p4MsWi7DKEFXMk4MvVyEbv4niHQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] fanotify,audit: deliver fan_info as a hex-encoded string
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 9, 2022 at 1:23 PM Richard Guy Briggs <rgb@redhat.com> wrote:
>
> Currently the only type of fanotify info that is defined is an audit
> rule number, but convert it to hex encoding to future-proof the field.
>
> Sample record:
>   type=FANOTIFY msg=audit(1659730979.839:284): resp=1 fan_type=0 fan_info=3F
>
> Suggested-by: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  kernel/auditsc.c | 28 +++++++++++++++++++++-------
>  1 file changed, 21 insertions(+), 7 deletions(-)

This needs to be squashed with patch 3/4; it's a user visible change
so we don't want someone backporting 3/4 without 4/4, especially when
it is part of the same patchset.

> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index f000fec52360..0f747015c577 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -2908,22 +2908,36 @@ void __audit_fanotify(u32 response, size_t len, char *buf)
>
>         if (!(len && buf)) {
>                 audit_log(audit_context(), GFP_KERNEL, AUDIT_FANOTIFY,
> -                         "resp=%u fan_type=0 fan_info=?", response);
> +                         "resp=%u fan_type=0 fan_info=3F", response); /* "?" */

Please drop the trailing comment, it's not necessary and it makes the
code messier.

>                 return;
>         }
>         while (c >= sizeof(struct fanotify_response_info_header)) {
> +               struct audit_context *ctx = audit_context();
> +               struct audit_buffer *ab;
> +
>                 friar = (struct fanotify_response_info_audit_rule *)buf;
>                 switch (friar->hdr.type) {
>                 case FAN_RESPONSE_INFO_AUDIT_RULE:
>                         if (friar->hdr.len < sizeof(*friar)) {
> -                               audit_log(audit_context(), GFP_KERNEL, AUDIT_FANOTIFY,
> -                                         "resp=%u fan_type=%u fan_info=(incomplete)",
> -                                         response, friar->hdr.type);
> +                               ab = audit_log_start(ctx, GFP_KERNEL, AUDIT_FANOTIFY);
> +                               if (ab) {
> +                                       audit_log_format(ab, "resp=%u fan_type=%u fan_info=",
> +                                                        response, friar->hdr.type);
> +#define INCOMPLETE "(incomplete)"
> +                                       audit_log_n_hex(ab, INCOMPLETE, sizeof(INCOMPLETE));

Is the distinction between "?" and "(incomplete)" really that
important?  I'm not going to go digging through all of the
audit_log_format() callers to check, but I believe there is precedence
for using "?" not only for when a value is missing, but when it is
bogus as well.

If we are really going to use "(incomplete)" here, let's do a better
job than defining a macro mid-function and only using it in one other
place - the line immediately below the definition.  This is both ugly
and a little silly (especially when one considers that the macro name
is almost exactly the same as the string it replaces.  If we must use
"(incomplete)" here, just ditch the macro; any conceptual arguments
about macros vs literals is largely rendered moot since there is only
one user.

> +                                       audit_log_end(ab);
> +                               }
>                                 return;
>                         }
> -                       audit_log(audit_context(), GFP_KERNEL, AUDIT_FANOTIFY,
> -                                 "resp=%u fan_type=%u fan_info=%u",
> -                                 response, friar->hdr.type, friar->audit_rule);
> +                       ab = audit_log_start(ctx, GFP_KERNEL, AUDIT_FANOTIFY);
> +                       if (ab) {
> +                               audit_log_format(ab, "resp=%u fan_type=%u fan_info=",
> +                                                response, friar->hdr.type);
> +                               audit_log_n_hex(ab, (char *)&friar->audit_rule,
> +                                               sizeof(friar->audit_rule));
> +                               audit_log_end(ab);
> +
> +                       }
>                 }
>                 c -= friar->hdr.len;
>                 ib += friar->hdr.len;
> --
> 2.27.0

-- 
paul-moore.com
