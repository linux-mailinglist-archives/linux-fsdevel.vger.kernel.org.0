Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD90F6185B9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Nov 2022 18:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231993AbiKCRFm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Nov 2022 13:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231633AbiKCRFR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Nov 2022 13:05:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2BB1D0EC;
        Thu,  3 Nov 2022 10:04:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E5EB61F8A;
        Thu,  3 Nov 2022 17:04:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09ECFC433C1;
        Thu,  3 Nov 2022 17:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667495075;
        bh=+joR9NVTsHUffCgeuXOyUVVfI4JaMOo8gzGUT6ED320=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lysq/3AFiylziUli6KVvFnF7bJiasbmKzFUcNhVfTkWRD9+fer8IktrOeA3nVKTSI
         GCwC397eq5pBxpnEsfMVgxAAm+aJtuFVYXriOARNZQR+un2zwpV41bRQXPN55tvcIh
         eiwzIdqsa7p1M8HOi/tzxlvdXNmvtKxgqc4UkbYc2FMtzPgdGt7R+uXAQVJlspFfwm
         l1qXMeOEi6YAktN97wS0/u96P4+b35FLCqdwzJVsKp/oI48y/rtphqSh0gMxC/vxKn
         WsPJ3xBt8UkyGdze3KhSKRbeQa2OvYS4KmQHA0P/Q5k/a0lnDwJdNIuObeyMKHEUVC
         c9esc3Xngg3xA==
Received: by mail-lf1-f51.google.com with SMTP id g12so3910378lfh.3;
        Thu, 03 Nov 2022 10:04:34 -0700 (PDT)
X-Gm-Message-State: ACrzQf03NPHBymasP6428qDRII9I8DS+MS0W32k075Hw4xj1SEG7MhZE
        oY4N+HF5+k8bkHcRZkVIfvV+gGPqamkQJoHMC2Y=
X-Google-Smtp-Source: AMsMyM4IBiCzW6DPfrMvNTjRQkL2Kk699BmrmU6wEe280umT8RgunZyHPpGK1szQj9w/pAT5RmjJ7Gd+efisaRLBr/U=
X-Received: by 2002:a19:6512:0:b0:4a9:32dd:39a4 with SMTP id
 z18-20020a196512000000b004a932dd39a4mr12407327lfb.539.1667495072983; Thu, 03
 Nov 2022 10:04:32 -0700 (PDT)
MIME-Version: 1.0
References: <20221101184808.80747-1-gpiccoli@igalia.com>
In-Reply-To: <20221101184808.80747-1-gpiccoli@igalia.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 3 Nov 2022 18:04:21 +0100
X-Gmail-Original-Message-ID: <CAMj1kXH5B0Op7Aab45x_tdkM1YsoSJ9euNqLMzeJg4uK++ojJQ@mail.gmail.com>
Message-ID: <CAMj1kXH5B0Op7Aab45x_tdkM1YsoSJ9euNqLMzeJg4uK++ojJQ@mail.gmail.com>
Subject: Re: [PATCH V3] efi: pstore: Add module parameter for setting the
 record size
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-efi@vger.kernel.org,
        kernel-dev@igalia.com, kernel@gpiccoli.net, keescook@chromium.org,
        anton@enomsg.org, ccross@android.com, tony.luck@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 1 Nov 2022 at 19:48, Guilherme G. Piccoli <gpiccoli@igalia.com> wrote:
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
> this way allowing a much easier reading of the collected log, which
> wouldn't be scattered anymore among many small files.
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

Thanks, I'll queue this up for v6.2

> ---
>
> V3:
> - Stick with 1024 to the varname size (thanks Ard!).
> - Rebased to v6.1-rc3.
>
>
> Hey folks, I've tested multiple record_size values, using lz4, zstd, deflate
> and no compression. For smaller ones ( up to 4k), all cases worked (for
> deflate, there was some failures even with 1024, and even with this patch
> reverted). For bigger sizes, no compression/deflate fails for 8k+, lz4 for
> values bigger than 16k and zstd only for values more then 20k.
>
> I've instrumented the function efivar_set_variable_locked() to get the return
> value during panic, and when it fails, usually it gives 0x8000000000000002
> (EFI_INVALID_PARAMETER it seems?). It's not related to this patch specifically,
> but worth mentioning in case you have ideas.
>
> Thanks,
>
>
> Guilherme
>
>
>  drivers/firmware/efi/efi-pstore.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/firmware/efi/efi-pstore.c b/drivers/firmware/efi/efi-pstore.c
> index 3bddc152fcd4..81ed4fc6d76d 100644
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
> +               varname_size = 1024;
>
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
