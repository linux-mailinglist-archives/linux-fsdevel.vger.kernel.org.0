Return-Path: <linux-fsdevel+bounces-67219-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1A4C38290
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 23:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DD2744F3D61
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 22:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD672F0C66;
	Wed,  5 Nov 2025 22:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="FCw+L7bS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5F429898B;
	Wed,  5 Nov 2025 22:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762381001; cv=none; b=oOmnvmOcfCNxjZIQ7/sB/qd4vO+W1AWtvZpPlJvMBdszYj0Nt8uOJR5xaZZWYcXRVTb/4r6RX1jBNELMWf2czY3Q6GIkb/hF/DE6Vig6Vbx5jDL2OazFW5yeyepJdryewOjph9wwllqXqP+cfSBoCSFY0UbLGq3HFOZMlXP+oqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762381001; c=relaxed/simple;
	bh=2a7QNJShN1PwXOOabfbcQHaM9xIZsGpRzjxizIKSKZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cHCpGxrejOXuYLoEJ5GlvEQcFRR0SuV5jtnOf59Xgtz5TVE480D1OFxtvljw+CsY7pnZJtNzIWc1MRhWefbFWUdBxREmOtU/VTsRU+1Qwce1pgUgEQ73BosnxB0zz7TyNJa+9HXAkyVGMJFu46JYgU7VWNxkGGdZhROEG/StQHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=FCw+L7bS; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1762380990; x=1762985790; i=w_armin@gmx.de;
	bh=2a7QNJShN1PwXOOabfbcQHaM9xIZsGpRzjxizIKSKZE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=FCw+L7bSbAWDKSLD0NKg0iTr3gu78is1wQ+3avoK9nzptcvruBuLKCqAnZ2nTwe3
	 wMjiO/+Xnwo6VIIUy7v1uMJVMZKl6l8JxWL4AxizwZPfyluT7eL1XxOsQKMeR41jn
	 jZyyBW24RYEdET4G5h6XGJZwHfMxnlvD99rPSK4IyGXscPr/8u9f/SsrU8JncMw4A
	 jCcqGmLw1XrfdQ9mCOvH++GzW9YPcy/e8NbpOeNiG05Iy/RCbG4AQYRYPtUtpaFBB
	 PAI1a55UicgPY27cT7tdSh7ZB9Ys0SmPUIzogakyJ5L9somCzWCedxG50+ziUVDzg
	 dc3UAwa0f4jj7DWknw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([93.202.247.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M8hZJ-1vKufE3YEz-00F1HR; Wed, 05
 Nov 2025 23:16:30 +0100
Message-ID: <17515e4d-6e3b-4eb9-99eb-840933315d55@gmx.de>
Date: Wed, 5 Nov 2025 23:16:27 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] platform/x86: wmi: Prepare for future changes
To: Mario Limonciello <superm1@kernel.org>, viro@zeniv.linux.org.uk,
 brauner@kernel.org, hansg@kernel.org, ilpo.jarvinen@linux.intel.com
Cc: jack@suse.cz, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20251104204540.13931-1-W_Armin@gmx.de>
 <e40a0d9c-7f38-44ab-a954-b09c9687ea88@kernel.org>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <e40a0d9c-7f38-44ab-a954-b09c9687ea88@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:N22RwbSVWba+ZROhTSnv11lNkgsjQT+PCLO5LTw/g4rLg30ZZ4n
 aInmQU9d+NCawvFIy7iKXbiTg7LaOVLcKKgDyr/Z03YsC0MHhWY1o7Ll1tm815ZcIuSqrmG
 iqTm0daM0lJ6pzKat8iNEGbM2CHxyu8gFGeeBe2rJ+TibIT+WYOjIVLkZ2k6Q3bfK3fYB3s
 nJglHZemNUCaTjZZK+ssQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Zs7z59eG/kM=;YjNOiyXCcDWUprpOURrOUWTcDT9
 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

Am 04.11.25 um 21:52 schrieb Mario Limonciello:

> On 11/4/25 2:45 PM, Armin Wolf wrote:
>> After over a year of reverse engineering, i am finally ready to
>> introduce support for WMI-ACPI marshalling inside the WMI driver core.
> marshaling> Since the resulting patch series is quite large, i am=20
> planning to
>> submit the necessary patches as three separate patch series.
>>
>> This is supposed to be the first of the three patch series. Its main
>> purpose is to prepare the WMI driver core for the upcoming changes.
>> The first patch fixes an issue inside the nls utf16 to utf8 conversion
>> code, while the next two patches fix some minor issues inside the WMI
>> driver core itself. The last patch finally moves the code of the WMI
>> driver core into a separate repository to allow for future additions
>> without cluttering the main directory.
>
> One question I have here on the patch to move things.
>
> Since Windows on ARM (WoA) laptops are a thing - is this still=20
> actually x86 specific?=C2=A0 I am wondering if this should be moving to =
a=20
> different subsystem altogether like ACPI; especially now with this=20
> impending other large patch series you have on your way.

I know of a few WoA laptops that contain ACPI-WMI devices, meaning this dr=
iver is indeed not x86-specific.
However i need to make some changes to the WMI driver core (and actually t=
ests it on a AArch64 VM) first
before moving it out of drivers/platform/x86.

Once i am actually ready for this i would prefer to move the whole stuff t=
o drivers/platform, as drivers/acpi
IMHO is better suited for core ACPI drivers.

Thanks,
Armin Wolf

>>
>> Armin Wolf (4):
>> =C2=A0=C2=A0 fs/nls: Fix utf16 to utf8 conversion
>> =C2=A0=C2=A0 platform/x86: wmi: Use correct type when populating ACPI o=
bjects
>> =C2=A0=C2=A0 platform/x86: wmi: Remove extern keyword from prototypes
>> =C2=A0=C2=A0 platform/x86: wmi: Move WMI core code into a separate dire=
ctory
>>
>> =C2=A0 Documentation/driver-api/wmi.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
>> =C2=A0 MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 =
+-
>> =C2=A0 drivers/platform/x86/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 30 +------------------
>> =C2=A0 drivers/platform/x86/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
>> =C2=A0 drivers/platform/x86/wmi/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 34 ++++++++++++++++++++++
>> =C2=A0 drivers/platform/x86/wmi/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 8 +++++
>> =C2=A0 drivers/platform/x86/{wmi.c =3D> wmi/core.c} | 34 +++++++++++++-=
=2D-------
>> =C2=A0 fs/nls/nls_base.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 16 +++++++---
>> =C2=A0 include/linux/wmi.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 15 ++++------
>> =C2=A0 9 files changed, 84 insertions(+), 59 deletions(-)
>> =C2=A0 create mode 100644 drivers/platform/x86/wmi/Kconfig
>> =C2=A0 create mode 100644 drivers/platform/x86/wmi/Makefile
>> =C2=A0 rename drivers/platform/x86/{wmi.c =3D> wmi/core.c} (98%)
>>
>
> Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>

