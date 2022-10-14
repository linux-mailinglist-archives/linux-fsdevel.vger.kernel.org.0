Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 542DB5FF089
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Oct 2022 16:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbiJNOrB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Oct 2022 10:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiJNOrA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Oct 2022 10:47:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30633108DE0;
        Fri, 14 Oct 2022 07:46:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E898EB82349;
        Fri, 14 Oct 2022 14:46:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A59F4C433D7;
        Fri, 14 Oct 2022 14:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665758816;
        bh=+Xn7EvypzKm/j2kIQQOVJKovAex9DIRAtd86CGmNvJs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NSQFr0A78ymp4fEiHZkOV5+oynVMh1aQJl8SQSVRtpnV69CELu9LdYb6VS4aBxJsn
         eR8jLVIWvj8bMCJ6uert9dBy9aiJueW+7BiPp5RWFwla61D+ppjj1Ki2+fGE5owKzz
         QaLIf29CiqMnJtXXJ7HCng2bq4gPNSxJPTq3fvEgss6YV7qdxXl80XPeiKuNURZdih
         lnHmXxfA7e3Jb7DTgKIX32kHqJagCgYBura554R3hsuTwFZdzqWVf4RtdbgZYXSfcp
         Sa6k1Ri9+hqelmKuC8+ZQNv+pbhQbmVHr5KvDS3ZEUam1HtUbKpZ7AZb0eu1xttFAL
         2MS5UxS8wiNBg==
Received: by mail-lf1-f50.google.com with SMTP id m19so7537116lfq.9;
        Fri, 14 Oct 2022 07:46:56 -0700 (PDT)
X-Gm-Message-State: ACrzQf1wb8oD5y922RM16EHwEFezvx0v/2+6fqjzbyPztmmloy6smWEL
        g4Wz6PNssFSlV7l0EvHsgiafPDwqDvqSdyHGTo4=
X-Google-Smtp-Source: AMsMyM70jBR3TkDd72Iib93u3xIlq35Gfav9hP/fEFJt+zy6x01K4Tqn60MxsmuXAWApBzzYBKzkKfXQ6jRAieyMDIU=
X-Received: by 2002:a05:6512:104a:b0:4a2:9c7b:c9c with SMTP id
 c10-20020a056512104a00b004a29c7b0c9cmr1779285lfb.122.1665758814624; Fri, 14
 Oct 2022 07:46:54 -0700 (PDT)
MIME-Version: 1.0
References: <20221013210648.137452-1-gpiccoli@igalia.com> <20221013210648.137452-4-gpiccoli@igalia.com>
In-Reply-To: <20221013210648.137452-4-gpiccoli@igalia.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 14 Oct 2022 16:46:43 +0200
X-Gmail-Original-Message-ID: <CAMj1kXG7syjMsOL+AcUMfT0_nhGde6qc_6MexpdDtxFQpS2=7A@mail.gmail.com>
Message-ID: <CAMj1kXG7syjMsOL+AcUMfT0_nhGde6qc_6MexpdDtxFQpS2=7A@mail.gmail.com>
Subject: Re: [PATCH V2 3/3] efi: pstore: Add module parameter for setting the
 record size
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-efi@vger.kernel.org,
        kernel-dev@igalia.com, kernel@gpiccoli.net, keescook@chromium.org,
        anton@enomsg.org, ccross@android.com, tony.luck@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 13 Oct 2022 at 23:11, Guilherme G. Piccoli <gpiccoli@igalia.com> wrote:
>
> By default, the efi-pstore backend hardcode the UEFI variable size
> as 1024 bytes. The historical reasons for that were discussed by
> Ard in threads [0][1]:
>
> "there is some cargo cult from prehistoric EFI times going
> on here, it seems. Or maybe just misinterpretation of the maximum
> size for the variable *name* vs the variable itself.".
>
> "OVMF has
> OvmfPkg/OvmfPkgX64.dsc:
> gEfiMdeModulePkgTokenSpaceGuid.PcdMaxVariableSize|0x2000
> OvmfPkg/OvmfPkgX64.dsc:
> gEfiMdeModulePkgTokenSpaceGuid.PcdMaxVariableSize|0x8400
>
> where the first one is without secure boot and the second with secure
> boot. Interestingly, the default is
>
> gEfiMdeModulePkgTokenSpaceGuid.PcdMaxVariableSize|0x400
>
> so this is probably where this 1k number comes from."
>
> With that, and since there is not such a limit in the UEFI spec, we
> have the confidence to hereby add a module parameter to enable advanced
> users to change the UEFI record size for efi-pstore data collection,
> this way allowing a much easier reading of the collected log, which is
> not scattered anymore among many small files.
>
> Through empirical analysis we observed that extreme low values (like 8
> bytes) could eventually cause writing issues, so given that and the OVMF
> default discussed, we limited the minimum value to 1024 bytes, which also
> is still the default.
>
> [0] https://lore.kernel.org/lkml/CAMj1kXF4UyRMh2Y_KakeNBHvkHhTtavASTAxXinDO1rhPe_wYg@mail.gmail.com/
> [1] https://lore.kernel.org/lkml/CAMj1kXFy-2KddGu+dgebAdU9v2sindxVoiHLWuVhqYw+R=kqng@mail.gmail.com/
>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> ---
>
>
> V2:
> - Fixed a memory corruption bug in the code (that wasn't causing
> trouble before due to the fixed sized of record_size), thanks
> Ard for spotting this!
>
> - Added Ard's archeology in the commit message plus a comment
> with the reasoning behind the minimum value.
>
>
>  drivers/firmware/efi/efi-pstore.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/firmware/efi/efi-pstore.c b/drivers/firmware/efi/efi-pstore.c
> index 97a9e84840a0..827e32427ddb 100644
> --- a/drivers/firmware/efi/efi-pstore.c
> +++ b/drivers/firmware/efi/efi-pstore.c
> @@ -10,7 +10,9 @@ MODULE_IMPORT_NS(EFIVAR);
>
>  #define DUMP_NAME_LEN 66
>
> -#define EFIVARS_DATA_SIZE_MAX 1024
> +static unsigned int record_size = 1024;
> +module_param(record_size, uint, 0444);
> +MODULE_PARM_DESC(record_size, "size of each pstore UEFI var (in bytes, min/default=1024)");
>
>  static bool efivars_pstore_disable =
>         IS_ENABLED(CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE);
> @@ -30,7 +32,7 @@ static int efi_pstore_open(struct pstore_info *psi)
>         if (err)
>                 return err;
>
> -       psi->data = kzalloc(EFIVARS_DATA_SIZE_MAX, GFP_KERNEL);
> +       psi->data = kzalloc(record_size, GFP_KERNEL);
>         if (!psi->data)
>                 return -ENOMEM;
>
> @@ -52,7 +54,7 @@ static inline u64 generic_id(u64 timestamp, unsigned int part, int count)
>  static int efi_pstore_read_func(struct pstore_record *record,
>                                 efi_char16_t *varname)
>  {
> -       unsigned long wlen, size = EFIVARS_DATA_SIZE_MAX;
> +       unsigned long wlen, size = record_size;
>         char name[DUMP_NAME_LEN], data_type;
>         efi_status_t status;
>         int cnt;
> @@ -133,7 +135,7 @@ static ssize_t efi_pstore_read(struct pstore_record *record)
>         efi_status_t status;
>
>         for (;;) {
> -               varname_size = EFIVARS_DATA_SIZE_MAX;
> +               varname_size = record_size;
>

I don't think we need this - this is the size of the variable name not
the variable itself.

>                 /*
>                  * If this is the first read() call in the pstore enumeration,
> @@ -224,11 +226,20 @@ static __init int efivars_pstore_init(void)
>         if (efivars_pstore_disable)
>                 return 0;
>
> -       efi_pstore_info.buf = kmalloc(4096, GFP_KERNEL);
> +       /*
> +        * Notice that 1024 is the minimum here to prevent issues with
> +        * decompression algorithms that were spotted during tests;
> +        * even in the case of not using compression, smaller values would
> +        * just pollute more the pstore FS with many small collected files.
> +        */
> +       if (record_size < 1024)
> +               record_size = 1024;
> +
> +       efi_pstore_info.buf = kmalloc(record_size, GFP_KERNEL);
>         if (!efi_pstore_info.buf)
>                 return -ENOMEM;
>
> -       efi_pstore_info.bufsize = 1024;
> +       efi_pstore_info.bufsize = record_size;
>
>         if (pstore_register(&efi_pstore_info)) {
>                 kfree(efi_pstore_info.buf);
> --
> 2.38.0
>
