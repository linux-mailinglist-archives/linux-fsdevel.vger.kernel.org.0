Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A58649BE3C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jan 2022 23:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233552AbiAYWLs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jan 2022 17:11:48 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60182 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbiAYWLq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jan 2022 17:11:46 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id EF8EA1F4466C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643148705;
        bh=haA1xD8icyCw96+5lD3ONdPtel9Z0YzFWe4Lj84edoI=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=gGWC8WrnglbRpa2lZ+JF+2BhOaLozx2WUUs7LujBWqzFnzm8vDFAwONl+shJ5/L6R
         Oh/TxTJhaFGHPHpEcuVFy3TGWyEt1MabgjXbczKy+mM0KaCE7DeZbQeMbm/+E0NTuE
         FxQffYo2xpJQscg8oyATSEguoAUZFv4I44UE2d3nTGVP1j+z122Z1YF5Cx8tL0u+jv
         PxlZ8EFDtRPu56J4dmsPYwOFbEYldyCtYJZKYKdrJUtrQqjUxPGqkbecpn7XuiXlT1
         3GfiUFSoslDNsLDssgT9AQUg0DSQ9enYp0dfEClpYxOmlOXSC/u7vuZKeDWc0fUiUW
         4NAJhDqmehRag==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Michal Simek <monstr@monstr.eu>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kbuild: unify cmd_copy and cmd_shipped
Organization: Collabora
References: <20220125064027.873131-1-masahiroy@kernel.org>
        <CAKwvOdm=-x1EP_xu2V_OZNdPid=gacVzCTx+=uSYqzCv+1Rbfw@mail.gmail.com>
Date:   Tue, 25 Jan 2022 17:11:41 -0500
In-Reply-To: <CAKwvOdm=-x1EP_xu2V_OZNdPid=gacVzCTx+=uSYqzCv+1Rbfw@mail.gmail.com>
        (Nick Desaulniers's message of "Tue, 25 Jan 2022 13:04:56 -0800")
Message-ID: <87h79rsbxe.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Nick Desaulniers <ndesaulniers@google.com> writes:

> On Mon, Jan 24, 2022 at 10:41 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>>
>> cmd_copy and cmd_shipped have similar functionality. The difference is
>> that cmd_copy uses 'cp' while cmd_shipped 'cat'.
>>
>> Unify them into cmd_copy because this macro name is more intuitive.
>>
>> Going forward, cmd_copy will use 'cat' to avoid the permission issue.
>> I also thought of 'cp --no-preserve=mode' but this option is not
>> mentioned in the POSIX spec [1], so I am keeping the 'cat' command.
>>
>> [1]: https://pubs.opengroup.org/onlinepubs/009695299/utilities/cp.html
>> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>> ---
>>
>>  arch/microblaze/boot/Makefile     |  2 +-
>>  arch/microblaze/boot/dts/Makefile |  2 +-
>>  fs/unicode/Makefile               |  2 +-
>>  scripts/Makefile.lib              | 12 ++++--------
>>  usr/Makefile                      |  4 ++--
>>  5 files changed, 9 insertions(+), 13 deletions(-)
>>
>> diff --git a/arch/microblaze/boot/Makefile b/arch/microblaze/boot/Makefile
>> index cff570a71946..2b42c370d574 100644
>> --- a/arch/microblaze/boot/Makefile
>> +++ b/arch/microblaze/boot/Makefile
>> @@ -29,7 +29,7 @@ $(obj)/simpleImage.$(DTB).ub: $(obj)/simpleImage.$(DTB) FORCE
>>         $(call if_changed,uimage)
>>
>>  $(obj)/simpleImage.$(DTB).unstrip: vmlinux FORCE
>> -       $(call if_changed,shipped)
>> +       $(call if_changed,copy)
>>
>>  $(obj)/simpleImage.$(DTB).strip: vmlinux FORCE
>>         $(call if_changed,strip)
>> diff --git a/arch/microblaze/boot/dts/Makefile b/arch/microblaze/boot/dts/Makefile
>> index ef00dd30d19a..b84e2cbb20ee 100644
>> --- a/arch/microblaze/boot/dts/Makefile
>> +++ b/arch/microblaze/boot/dts/Makefile
>> @@ -12,7 +12,7 @@ $(obj)/linked_dtb.o: $(obj)/system.dtb
>>  # Generate system.dtb from $(DTB).dtb
>>  ifneq ($(DTB),system)
>>  $(obj)/system.dtb: $(obj)/$(DTB).dtb
>> -       $(call if_changed,shipped)
>> +       $(call if_changed,copy)
>>  endif
>>  endif
>>
>> diff --git a/fs/unicode/Makefile b/fs/unicode/Makefile
>> index 2f9d9188852b..74ae80fc3a36 100644
>> --- a/fs/unicode/Makefile
>> +++ b/fs/unicode/Makefile
>> @@ -31,7 +31,7 @@ $(obj)/utf8data.c: $(obj)/mkutf8data $(filter %.txt, $(cmd_utf8data)) FORCE
>>  else
>>
>>  $(obj)/utf8data.c: $(src)/utf8data.c_shipped FORCE
>
> do we want to retitle the _shipped suffix for this file to _copy now, too?
> fs/unicode/Makefile:11
> fs/unicode/Makefile:33
> fs/unicode/Makefile:34

I think _copy doesn't convey the sense that this is distributed with the
kernel tree, even though it is also generated from in-tree sources.
Even if that is not the original sense of _shipped (is it?), it makes
sense to me that way, but _copy doesn't.

The patch looks good to me, though.

Reviewed-by: Gabriel Krisman Bertazi <krisman@collabora.com>


>
> Either way
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
>
>> -       $(call if_changed,shipped)
>> +       $(call if_changed,copy)
>>
>>  endif
>>
>> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
>> index 79be57fdd32a..40735a3adb54 100644
>> --- a/scripts/Makefile.lib
>> +++ b/scripts/Makefile.lib
>> @@ -246,20 +246,16 @@ $(foreach m, $(notdir $1), \
>>         $(addprefix $(obj)/, $(foreach s, $3, $($(m:%$(strip $2)=%$(s)))))))
>>  endef
>>
>> -quiet_cmd_copy = COPY    $@
>> -      cmd_copy = cp $< $@
>> -
>> -# Shipped files
>> +# Copy a file
>>  # ===========================================================================
>>  # 'cp' preserves permissions. If you use it to copy a file in read-only srctree,
>>  # the copy would be read-only as well, leading to an error when executing the
>>  # rule next time. Use 'cat' instead in order to generate a writable file.
>> -
>> -quiet_cmd_shipped = SHIPPED $@
>> -cmd_shipped = cat $< > $@
>> +quiet_cmd_copy = COPY    $@
>> +      cmd_copy = cat $< > $@
>>
>>  $(obj)/%: $(src)/%_shipped
>> -       $(call cmd,shipped)
>> +       $(call cmd,copy)
>>
>>  # Commands useful for building a boot image
>>  # ===========================================================================
>> diff --git a/usr/Makefile b/usr/Makefile
>> index cc0d2824e100..59d9e8b07a01 100644
>> --- a/usr/Makefile
>> +++ b/usr/Makefile
>> @@ -3,7 +3,7 @@
>>  # kbuild file for usr/ - including initramfs image
>>  #
>>
>> -compress-y                                     := shipped
>> +compress-y                                     := copy
>>  compress-$(CONFIG_INITRAMFS_COMPRESSION_GZIP)  := gzip
>>  compress-$(CONFIG_INITRAMFS_COMPRESSION_BZIP2) := bzip2
>>  compress-$(CONFIG_INITRAMFS_COMPRESSION_LZMA)  := lzma
>> @@ -37,7 +37,7 @@ endif
>>  # .cpio.*, use it directly as an initramfs, and avoid double compression.
>>  ifeq ($(words $(subst .cpio.,$(space),$(ramfs-input))),2)
>>  cpio-data := $(ramfs-input)
>> -compress-y := shipped
>> +compress-y := copy
>>  endif
>>
>>  endif
>> --
>> 2.32.0
>>

-- 
Gabriel Krisman Bertazi
