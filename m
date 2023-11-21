Return-Path: <linux-fsdevel+bounces-3335-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3386A7F3726
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 21:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 642071C20B3B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 20:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED070487AD;
	Tue, 21 Nov 2023 20:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C06112;
	Tue, 21 Nov 2023 12:12:40 -0800 (PST)
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-58a106dd421so289204eaf.0;
        Tue, 21 Nov 2023 12:12:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700597559; x=1701202359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5z/CJO7e3iTwW4OMryoZAQBQUEGSEP4jZRhULM4OHDs=;
        b=niODAcAYzbWEiM4h00v4dGeZa1l50jnblAiSSSTVxyaXgJs9dYkynkt8jJ7Y0hBiJg
         kzW/N4FzmAL0Hw2leXPBwZ0KJMsF/i8sqONruOxI0O6WTnUBb9zAzvdkoYsb2oGgroWd
         PwM8GDbtZI+UltWgBgdOc4U5sD0KcCtUWnuZ1NUvu3vdqyU3WdK7z/tJ29OJZyXdfXkK
         l6MeSWpMwolqd+StjrYRCsRf8RWlrucCDu9uAMH1b3kxSw0cHDYFHQUZhiAnZiZ+rIRn
         dBFxtXcyUS/sg2vpPBAdoUqkASzZwpHHA0ZXSZKjyv+SbRmf8/DfeGGrwwUBnhPjXnBD
         1Rdw==
X-Gm-Message-State: AOJu0YzRSHkWcHHLbVvb7lqVysoIkI7/4clFaJMYW6pYDXzZZ2JhBDnF
	N6v5q9+6xDrJNbo6IMmuRI2J1B8sUDt/ga8L7Z4=
X-Google-Smtp-Source: AGHT+IEPpI7LCkGuTlQ2ai4rgFgZxkdyiflGAcrmt0ZxmM0ZeZKNY3C9NGeoHJYYe5NxiwO+1ax2JVnzEJE83F9MLsI=
X-Received: by 2002:a05:6820:311:b0:58c:e80a:537d with SMTP id
 l17-20020a056820031100b0058ce80a537dmr459120ooe.1.1700597559366; Tue, 21 Nov
 2023 12:12:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231116224725.3695952-1-avadhut.naik@amd.com>
In-Reply-To: <20231116224725.3695952-1-avadhut.naik@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 21 Nov 2023 21:12:28 +0100
Message-ID: <CAJZ5v0icY=_s6hZGajv4cQr4yYoWZACy5sKQGD4qKsf+z2H5UA@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] Add support for Vendor Defined Error Types in Einj Module
To: Avadhut Naik <avadhut.naik@amd.com>
Cc: linux-acpi@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	rafael@kernel.org, gregkh@linuxfoundation.org, lenb@kernel.org, 
	james.morse@arm.com, tony.luck@intel.com, bp@alien8.de, 
	linux-kernel@vger.kernel.org, alexey.kardashevskiy@amd.com, 
	yazen.ghannam@amd.com, avadnaik@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 16, 2023 at 11:47=E2=80=AFPM Avadhut Naik <avadhut.naik@amd.com=
> wrote:
>
> This patchset adds support for Vendor Defined Error types in the einj
> module by exporting a binary blob file in module's debugfs directory.
> Userspace tools can write OEM Defined Structures into the blob file as
> part of injecting Vendor defined errors. Similarly, the very tools can
> also read from the blob file for information, if any, provided by the
> firmware after error injection.
>
> The first patch refactors available_error_type_show() function to ensure
> all errors supported by the platform are output through einj module's
> available_error_type file in debugfs.
>
> The second patch adds a write callback for binary blobs created through
> debugfs_create_blob() API.
>
> The third patch fixes the permissions of panicinfo file in debugfs to
> ensure it remains read-only
>
> The fourth patch adds the required support i.e. establishing the memory
> mapping and exporting it through debugfs blob file for Vendor-defined
> Error types.
>
> Changes in v2:
>  - Split the v1 patch, as was recommended, to have a separate patch for
> changes in debugfs.
>  - Refactored available_error_type_show() function into a separate patch.
>  - Changed file permissions to octal format to remove checkpatch warnings=
.
>
> Changes in v3:
>  - Use BIT macro for generating error masks instead of hex values since
> ACPI spec uses bit numbers.
>  - Handle the corner case of acpi_os_map_iomem() returning NULL through
> a local variable to a store the size of OEM defined data structure.
>
> Changes in v4:
>  - Fix permissions for panicinfo file in debugfs.
>  - Replace acpi_os_map_iomem() and acpi_os_unmap_iomem() calls with
>    acpi_os_map_memory() and acpi_os_unmap_memory() respectively to avert
>    sparse warnings as suggested by Alexey.
>
> Changes in v5:
>  - Change permissions of the "oem_error" file, being created in einj
>    module's debugfs directory, from "w" to "rw" since system firmware
>    in some cases might provide some information through OEM-defined
>    structure for tools to consume.
>  - Remove Reviewed-by: Alexey Kardashevskiy <aik@amd.com> from the
>    fourth patch since permissions of the oem_error file have changed.
>  - Add Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org> for
>    second and third patch.
>  - Rebase on top of tip master.
>
> Changes in v6:
>  - Minor formatting undertaken in the first and fourth patch per v5
>    feedback by Boris.
>  - Added check in the second patch to ensure that only owners can write
>    into the binary blob files. Mentioned the same in commit description.
>  - Modified commit description of the third patch per recommendations
>    provided by Tony.
>  - Add Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de> for first and
>    fourth patch.
>  - Add Reviewed-by: Tony Luck <tony.luck@intel.com> for second, third and
>    fourth patch.
>
>
> [NOTE:
>
>  - The second patch already had the below tags for v5:
>     Reviewed-by: Alexey Kardashevskiy <aik@amd.com>
>     Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
>    Since the changes to the patch for v6 are very minimal i.e. addition o=
f
>    a check to ensure that only owners write into the blobs, have retained
>    the tags for v6 as well.
>
>  - Similarly, the third patch already had the below tag for v5:
>     Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
>    Since only the commit description was slightly changed for this patch
>    in v6, have retained the tag for v6 too.
>
>    Having said so, if advised, will attempt to reacquire the tags.]
>
>
> Avadhut Naik (4):
>   ACPI: APEI: EINJ: Refactor available_error_type_show()
>   fs: debugfs: Add write functionality to debugfs blobs
>   platform/chrome: cros_ec_debugfs: Fix permissions for panicinfo
>   ACPI: APEI: EINJ: Add support for vendor defined error types
>
>  drivers/acpi/apei/einj.c                  | 71 +++++++++++++++--------
>  drivers/platform/chrome/cros_ec_debugfs.c |  2 +-
>  fs/debugfs/file.c                         | 28 +++++++--
>  3 files changed, 72 insertions(+), 29 deletions(-)
>
>
> base-commit: a1cc6ec03d1e56b795607fce8442222b37d1dd99
> --

All patches in the series applied as 6.8 material, thanks!

