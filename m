Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDF1D419201
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Sep 2021 12:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233796AbhI0KKn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Sep 2021 06:10:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46422 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233747AbhI0KKn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Sep 2021 06:10:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632737344;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WgO9Fjl4OcAgYGVjtzMRiOwa5eVYSll8vIeR9E0XZlo=;
        b=QC3W4loz443WtQbA2n2uFmA8M//CDB2E1iWeZOgLAFDXblu0l2ifF6/V+cQm0yEuP3H7gm
        mjcyCZdy1Lbq4bi1HoIrzsYPheKGIIBG8k8hhX0lyGFmdpVVweuTgjAg4BnFM6ykOkMuWY
        Vw5fhbWetcwW54UiH6FK2Pce5eLdFao=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-554-CRSV-yswNxKEuBL6Gy7u-w-1; Mon, 27 Sep 2021 06:09:03 -0400
X-MC-Unique: CRSV-yswNxKEuBL6Gy7u-w-1
Received: by mail-ed1-f70.google.com with SMTP id h6-20020a50c386000000b003da01adc065so17120727edf.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Sep 2021 03:09:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WgO9Fjl4OcAgYGVjtzMRiOwa5eVYSll8vIeR9E0XZlo=;
        b=esv0cNOf3hVCVIY4R5Y6VrCxhM45JS5TsRsu2CC59ZcvIo0RxuhwqulE8Y4rsBVZkX
         lxDD++tU6jVAk1MvGNVb7Rcd/RN8S7JoU7v2U9vygGWkUpB6cYNWwUViT0EuYdBp6X5B
         K60Ur7wSZKFWNLNooWWh6kL1Hc+18HwUlb7Zh8RTDEcjeBVB80A0ZD0NZ3/v2uOrriM8
         HXfy6vObXtWZ4GYUCHdax4+SXCIH8C6T7Avd2J30iKEEkUxzipLZFPIiX/3sotI37CkI
         3vZ+TzTBK5oTsNSHkT7vM7yTabkM0PJ3n1c1M8i3HXad7cgZYueGxpvp+t6UP7PP/PtM
         bUDw==
X-Gm-Message-State: AOAM530h8ARhxuNLfA+HLxcQwAoUpwT7U1LKbJkkc7hEynv5mF6nAn/n
        Wt0HTW1gtGuHR17qyyFe949eDdC6/aSto84RWoSyJ+YeagzkXSwANCcBRgxLtDLobZcMzjaSt0P
        0lMsf3TiifTFrOVY1j7IQpyrcRQ==
X-Received: by 2002:a17:906:fcad:: with SMTP id qw13mr25563718ejb.127.1632737342121;
        Mon, 27 Sep 2021 03:09:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw8U1+f3TegbtJxSIAhpvPLVIJ5nh9xqDjUNY04ahqwTGF7oe5vjxEJRPoPXikOQjPjCLX3Ew==
X-Received: by 2002:a17:906:fcad:: with SMTP id qw13mr25563702ejb.127.1632737341905;
        Mon, 27 Sep 2021 03:09:01 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id p26sm4312438eds.58.2021.09.27.03.09.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Sep 2021 03:09:01 -0700 (PDT)
Subject: Re: [PATCH] vboxsf: fix old signature detection
To:     Arnd Bergmann <arnd@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
References: <20210927094123.576521-1-arnd@kernel.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <40217483-1b8d-28ec-bbfc-8f979773b166@redhat.com>
Date:   Mon, 27 Sep 2021 12:09:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210927094123.576521-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On 9/27/21 11:40 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The constant-out-of-range check in clang found an actual bug in
> vboxsf, which leads to the detection of old mount signatures always
> failing:
> 
> fs/vboxsf/super.c:394:21: error: result of comparison of constant -3 with expression of type 'unsigned char' is always false [-Werror,-Wtautological-constant-out-of-range-compare]
>                        options[3] == VBSF_MOUNT_SIGNATURE_BYTE_3) {
>                        ~~~~~~~~~~ ^  ~~~~~~~~~~~~~~~~~~~~~~~~~~~

This actually seems to be a clang bug though, or at least a weird
interpretation (and different from gcc) of the C spec.

VBSF_MOUNT_SIGNATURE_BYTE_3 is defined as:

#define VBSF_MOUNT_SIGNATURE_BYTE_3 ('\375')

The C-spec:

http://port70.net/~nsz/c/c11/n1570.html#6.4.4.4p5

Says the following:

"The octal digits that follow the backslash in an octal escape sequence are taken to be part of the construction of a single character for an integer character constant or of a single wide character for a wide character constant. The numerical value of the octal integer so formed specifies the value of the desired character or wide character."

Character constants have a type of int, so 0375
clearly fits in the range of that.

I guess the problem is that gcc sees this as

const int VBSF_MOUNT_SIGNATURE_BYTE_3 = 0375;

Where as clang sees this as:

const int VBSF_MOUNT_SIGNATURE_BYTE_3 = (char)0375;

Which is a nice subtle incompatibility between the 2 :|


With that said, the patch is fine and I have no objections
against it:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Although maybe it is better to actually remove any
ambiguity and just replace the defines with:

static const u8 VBSF_MOUNT_SIGNATURE_BYTE_0 = 0000;
static const u8 VBSF_MOUNT_SIGNATURE_BYTE_1 = 0377;
static const u8 VBSF_MOUNT_SIGNATURE_BYTE_2 = 0376;
static const u8 VBSF_MOUNT_SIGNATURE_BYTE_3 = 0375;

?

Regards,

Hans










> fs/vboxsf/super.c:393:21: error: result of comparison of constant -2 with expression of type 'unsigned char' is always false [-Werror,-Wtautological-constant-out-of-range-compare]
>                        options[2] == VBSF_MOUNT_SIGNATURE_BYTE_2 &&
>                        ~~~~~~~~~~ ^  ~~~~~~~~~~~~~~~~~~~~~~~~~~~
> fs/vboxsf/super.c:392:21: error: result of comparison of constant -1 with expression of type 'unsigned char' is always false [-Werror,-Wtautological-constant-out-of-range-compare]
>                        options[1] == VBSF_MOUNT_SIGNATURE_BYTE_1 &&
>                        ~~~~~~~~~~ ^  ~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> The problem is that the pointer is of type 'unsigned char' but the
> constant is a 'char'. My first idea was to change the type of the
> pointer to 'char *', but I noticed that this was the original code
> and it got changed after 'smatch' complained about this.
> 
> I don't know if there is a bug in smatch here, but it sounds to me
> that clang's warning is correct. Forcing the constants to an unsigned
> type should make the code behave consistently and avoid the warning
> on both.
> 
> Fixes: 9d682ea6bcc7 ("vboxsf: Fix the check for the old binary mount-arguments struct")
> Cc: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  fs/vboxsf/super.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/vboxsf/super.c b/fs/vboxsf/super.c
> index 4f5e59f06284..84e2236021de 100644
> --- a/fs/vboxsf/super.c
> +++ b/fs/vboxsf/super.c
> @@ -21,10 +21,10 @@
>  
>  #define VBOXSF_SUPER_MAGIC 0x786f4256 /* 'VBox' little endian */
>  
> -#define VBSF_MOUNT_SIGNATURE_BYTE_0 ('\000')
> -#define VBSF_MOUNT_SIGNATURE_BYTE_1 ('\377')
> -#define VBSF_MOUNT_SIGNATURE_BYTE_2 ('\376')
> -#define VBSF_MOUNT_SIGNATURE_BYTE_3 ('\375')
> +#define VBSF_MOUNT_SIGNATURE_BYTE_0 (u8)('\000')
> +#define VBSF_MOUNT_SIGNATURE_BYTE_1 (u8)('\377')
> +#define VBSF_MOUNT_SIGNATURE_BYTE_2 (u8)('\376')
> +#define VBSF_MOUNT_SIGNATURE_BYTE_3 (u8)('\375')
>  
>  static int follow_symlinks;
>  module_param(follow_symlinks, int, 0444);
> 

