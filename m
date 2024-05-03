Return-Path: <linux-fsdevel+bounces-18578-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A72548BA962
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 11:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66C59281A1B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 09:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2ED14F9CD;
	Fri,  3 May 2024 09:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hNizHVdn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0F214F62;
	Fri,  3 May 2024 09:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714727029; cv=none; b=TDRL4EknNrGXbQ6QjtvmwpCKLyslIu7ZAmooBe+3ewAu4NtSHr2sykMGt9gdhj9zwYRhcfVH0VW5E3hWkfFuU9lP3PpAufU4knwCr451STs+P+h9Uw6FoAzVRUtBhJFEH5JlOB9sGXJqfoUv5Dfn50FH9VfyZILCDIgLKD30yWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714727029; c=relaxed/simple;
	bh=H4OwBwwEJLoUrKgErNPAJ4aWKXfqp1/GW2h+1cPY6mY=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=LELIdvB94u4VG7Xl+VUb+dOAlJzdIImPOiWg1ONIISGco6uNrDnbtN5vQuS2LAJ/NRfJUIRebhYvF6BE23O6h6qdT/UUemv/kqLLeDooaSN6kwrjugPZgWSH3yX8qfUt6xL4WSNKVgbgrCFU8Y2NquZSNlxFAkDNfVMKlyJMboY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=hNizHVdn; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240503090338euoutp0194b4a66649b9801585df2f01f69d5a50~L7yOBYBSa0516505165euoutp01e;
	Fri,  3 May 2024 09:03:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240503090338euoutp0194b4a66649b9801585df2f01f69d5a50~L7yOBYBSa0516505165euoutp01e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1714727018;
	bh=5DfAXm0BybfL0wB90HdoJ2+ecXzl3T3phLFwP9QlX+o=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=hNizHVdn9K9XbhBNhn1nDSO/5KZUNj2XoxMSsTacSd3jPs0o0drSRiC4H6bkslwSW
	 B/QSvO9HwlzhFW4zaHFyGSJ5H6nnh83o7MAyLAhqznaRM1mK98m5CnfxgNvbZnC8qx
	 hsrB//hR8ZhJR5rlu9tY5Zsijl1EM085ggZXO+JQ=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240503090338eucas1p1622ca105c87c20c6bbe96b62943fe717~L7yNnz7IW1025710257eucas1p1p;
	Fri,  3 May 2024 09:03:38 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 2A.F6.09624.A68A4366; Fri,  3
	May 2024 10:03:38 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240503090337eucas1p17add844fd822fa0889270ae9e12ca4d0~L7yM6N_nm1858018580eucas1p1z;
	Fri,  3 May 2024 09:03:37 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240503090337eusmtrp2e33e44757c1c281d7e60e444934cfff9~L7yM4xFdH1141911419eusmtrp2R;
	Fri,  3 May 2024 09:03:37 +0000 (GMT)
X-AuditID: cbfec7f2-bfbff70000002598-4f-6634a86abd4b
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id DB.59.08810.968A4366; Fri,  3
	May 2024 10:03:37 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240503090337eusmtip245d74ecfb1a665d8dac0f5363231e909~L7yMjDsdX1588515885eusmtip2r;
	Fri,  3 May 2024 09:03:37 +0000 (GMT)
Received: from localhost (106.210.248.112) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Fri, 3 May 2024 10:03:36 +0100
Date: Fri, 3 May 2024 11:03:32 +0200
From: Joel Granados <j.granados@samsung.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
CC: Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>,
	Eric Dumazet <edumazet@google.com>, Dave Chinner <david@fromorbit.com>,
	<linux-fsdevel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-s390@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<linux-mm@kvack.org>, <linux-security-module@vger.kernel.org>,
	<bpf@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-xfs@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, <netfilter-devel@vger.kernel.org>,
	<coreteam@netfilter.org>, <kexec@lists.infradead.org>,
	<linux-hardening@vger.kernel.org>, <bridge@lists.linux.dev>,
	<lvs-devel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<rds-devel@oss.oracle.com>, <linux-sctp@vger.kernel.org>,
	<linux-nfs@vger.kernel.org>, <apparmor@lists.ubuntu.com>
Subject: Re: [PATCH v3 00/11] sysctl: treewide: constify ctl_table argument
 of sysctl handlers
Message-ID: <20240503090332.irkiwn73dgznjflz@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="pu6elde4hy573vso"
Content-Disposition: inline
In-Reply-To: <20240423-sysctl-const-handler-v3-0-e0beccb836e2@weissschuh.net>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA2VSfUxTVxzNfe/1vVe24mvp5AZkZIiayIcQWbzZKrC4Px4hM5PMLPLHRjOe
	4KBFW2DqdOJEFHBbBVEpX2UiMnDFFKhURLFjRcABG8SgwzI+SkBwQIsCq8Isj80l++/8fuec
	e8+5uTQueUh60fuUqZxKKU/2I90Io2WxK+jzqrC9IUNmD3TcohMgR2sbiYyXcjH0wnQKR/UW
	K0A2yzCF7uUqUFPnUwwZRu4L0M3mdgKV1i4C1HujmETWq8sC1NPSKUB9DXoCjZm/IZDRkUki
	TfkJHNl0kwI0c2aYRK21vxDoxvNGCjkXxjDknF8SoBNldhz1a2wAWXRrkUbfQaCuOocg0oct
	yviVYDu+h6zOkMYaqrNJ1mDPo9i6imPseF0hYLsvlgP2fv8gwT5x3sXYnsopknUY3mS/y7VQ
	H4pi3WTxXPK+dE61JTzOLdFp+53cX/Txwe7BnRmgKzIHCGnIhME7lmtkDnCjJUwVgCPTdwA/
	zAE4N/ktcKkkjAPAWze/ygH0iuPHOU9ecwXAyXsj+L+a8Uev80Q9gDWjfwhcBMH4w7qJbMyF
	SSYQdk8NrBikjAz+8MxBuTDOFFCw6HqcC3swcbD+cv7KxSImElr1TQSPxbC9cJRwhcCZg3Bo
	IZaH3vDKEu1SCJkPYFbFNMEXWw9br5dQPD4KO+ofYq5okJlxg+bZUcAT78MzDXwcyHjAx231
	q4Z1cNlUtmrIB/D20gzFDzUAVh5/ivGqd2Fm3+iq4z1o7X4A+Bdyh/1PxHwvd5hnvIDzaxE8
	nSXh1RthjXWK0ID12v80075qpn3VTLtyTiDUNdnJ/60DYGX5JM7j7VCvnyZ0gKoGnlyaWpHA
	qUOV3BfBarlCnaZMCP4sRWEAL79851KbvRGUPJ4NNgOMBmbg/9I8fK2mB3gRyhQl5ycVBeRv
	3SsRxcsPHeZUKZ+q0pI5tRl404Sfp2hDvC8nYRLkqVwSx+3nVP+wGC30ysDSCwPswc2nK7SJ
	u46EjoZI18i6djc81wszz+8oGTq/uaSpb+sBQ4nBMeAYxCxHt/w82WOq0J9rEAu/jL1Iz8dE
	ptnz9kTQittJBedyNeiyqSV5g8mnWi3rLDwy5/A1/8aG9RbtpDZVuTuXo7F37k6cahf31Ebs
	ic4wmiOTZLNXLxXj0nZpcdCScxf3SX/42fbyRXHjuvE3os5ub342sM2my/bxpeThu/Heqbe8
	s5ix0sAHZTXzh4YOX1g4kBdi++kYFYSZQv862TlRUNsijSqNDjhpWBO+rFnruWnbeNzbSoX7
	xhfuMfiOMLEs97WCr4MiokI+umV8FAPT/0xs809K9SPUifLQzbhKLf8bTKfE620EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJKsWRmVeSWpSXmKPExsVy+t/xe7qZK0zSDH7sl7VoPLaA1eLzkeNs
	FtsWdzNZ/N3Zzmyx5dg9Rounxx6xW5zpzrXYffork8Wmx9dYLfbsPcliMW/9T0aLy7vmsFnc
	W/Of1eLCgdOsFle2rmOxeHaol8Vi2+cWNosJC5uZLZ4ueM1q8aHnEZvFkfVnWSx2/dnBbvH7
	xzMmi9/f/7FaNM//xGxxY8JTRotjC8QsJqw7xWJxbvNnVgdZj9kNF1k8Ti2S8FiwqdRj06pO
	No9Nnyaxe2xeUu/xYvNMRo/zMxYyely7cZ/F4+3vE0weF5a9YfP4vEnOo7/7GHsAb5SeTVF+
	aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6dTUpqTmZZapG+XYJexpz+v0wFM8Mr
	Ph6+xNrAeMahi5GDQ0LARGLtF/EuRi4OIYGljBI3+n6ydDFyAsVlJDZ+ucoKYQtL/LnWxQZR
	9JFR4tebn8wQzhZGietnD4F1sAioSGx+2ckEYrMJ6Eicf3OHGcQWEbCRWPntMzuIzSwwlV1i
	9vYEEFtYIEFiy9LJjCA2r4CDxL11u1kghi5glJjevhYqIShxcuYTFpBTmQXKJN7fNoYwpSWW
	/+MAqeAU8JVoW/Ie6mhliSPb57JD2LUSn/8+Y5zAKDwLyaBZCINmIQyaBXablsSNfy+ZMIS1
	JZYtfM0MYdtKrFv3nmUBI/sqRpHU0uLc9NxiQ73ixNzi0rx0veT83E2MwHS37djPzTsY5736
	qHeIkYmD8RCjClDnow2rLzBKseTl56UqifBqTzZOE+JNSaysSi3Kjy8qzUktPsRoCgzDicxS
	osn5wEScVxJvaGZgamhiZmlgamlmrCTO61nQkSgkkJ5YkpqdmlqQWgTTx8TBKdXANH3uY4E0
	2xYBo9Mirv0ldwM2JeXqPak55K24q+zrxBohrh2WGfamDnIvAq2vLWOefW1xx/xL/75ENCX9
	vqot8bXk/BKxn6F9nTImM+a53WtI2Xgg3tez4H/e1kWOlx5e8/WsP/e1yuuIcl/Z/wLbadY8
	KiufaMxeF5jCvf62Uu03kYK5wRGfjrzc92dKt2DT2pBb3qeD5d7cEz/wpqLi2sLZNb+7lkZM
	n+Ie5awmssqS9+w9mbNLU2RnBT5VsBSSrBRo3iWV/Wb3rR8mMzi+2SzRU5f6N7MyzCXp4P/d
	yaIWaeGfHbVicn6JfVP4Uf55nj6jjUNn7tegOU2nuZ60PNqZxc/sn/6VMT1xt32vEktxRqKh
	FnNRcSIAsZFFMwwEAAA=
X-CMS-MailID: 20240503090337eucas1p17add844fd822fa0889270ae9e12ca4d0
X-Msg-Generator: CA
X-RootMTR: 20240423075608eucas1p265e7c90f3efd6995cb240b3d2688b803
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240423075608eucas1p265e7c90f3efd6995cb240b3d2688b803
References: <CGME20240423075608eucas1p265e7c90f3efd6995cb240b3d2688b803@eucas1p2.samsung.com>
	<20240423-sysctl-const-handler-v3-0-e0beccb836e2@weissschuh.net>

--pu6elde4hy573vso
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Thomas

Here is my feedback for your outstanding constification patches [1] and [2].

# You need to split the patch
The answer that you got from Jakub in the network subsystem is very clear a=
nd
baring a change of heart from the network folks, this will go in as but as a
split patchset. Please split it considering the following:
1. Create a different patchset for drivers/,  fs/, kernel/, net, and a
   miscellaneous that includes whatever does not fit into the others.
2. Consider that this might take several releases.
3. Consider the following sufix for the interim function name "_const". Lik=
e in
   kfree_const. Please not "_new".
4. Please publish the final result somewhere. This is important so someone =
can
   take over in case you need to stop.
5. Consistently mention the motivation in your cover letters. I specify more
   further down in "#Motivation".
6. Also mention that this is part of a bigger effort (like you did in your
   original cover letters). I would include [3,4,5,6]
7. Include a way to show what made it into .rodata. I specify more further =
down
   in "#Show the move".

# Motivation
As I read it, the motivation for these constification efforts are:
1. It provides increased safety: Having things in .rodata section reduces t=
he
   attack surface. This is especially relevant for structures that have fun=
ction
   pointers (like ctl_table); having these in .rodata means that these poin=
ters
   always point to the "intended" function and cannot be changed.
2. Compiler optimizations: This was just a comment in the patchsets that I =
have
   mentioned ([3,4,5]). Do you know what optimizations specifically? Does it
   have to do with enhancing locality for the data in .rodata? Do you have =
other
   specific optimizations in mind?
3. Readability: because it is easier to know up-front that data is not supp=
osed
   to change or its obvious that a function is re-entrant. Actually a lot o=
f the
   readability reasons is about knowing things "up-front".
As we move forward with the constification in sysctl, please include a more
detailed motivation in all your cover letters. This helps maintainers (that
don't have the context) understand what you are trying to do. It does not n=
eed
to be my three points, but it should be more than just "put things into
=2Erodata". Please tell me if I have missed anything in the motivation.

# Show the move
I created [8] because there is no easy way to validate which objects made it
into .rodata. I ran [8] for your Dec 2nd patcheset [7] and there are less in
=2Erodata than I expected (the results are in [9]) Why is that? Is it somet=
hing
that has not been posted to the lists yet?=20

Best

[1] https://lore.kernel.org/all/20240423-sysctl-const-handler-v3-0-e0beccb8=
36e2@weissschuh.net/
[2] https://lore.kernel.org/all/20240418-sysctl-const-table-arg-v2-1-4012ab=
c31311@weissschuh.net
[3] [PATCH v2 00/14] ASoC: Constify local snd_sof_dsp_ops
    https://lore.kernel.org/all/20240426-n-const-ops-var-v2-0-e553fe67ae82@=
kernel.org
[4] [PATCH v2 00/19] backlight: Constify lcd_ops
    https://lore.kernel.org/all/20240424-video-backlight-lcd-ops-v2-0-1aaa8=
2b07bc6@kernel.org
[5] [PATCH 1/4] iommu: constify pointer to bus_type
    https://lore.kernel.org/all/20240216144027.185959-1-krzysztof.kozlowski=
@linaro.org
[6] [PATCH 00/29] const xattr tables
    https://lore.kernel.org/all/20230930050033.41174-1-wedsonaf@gmail.com
[7] https://lore.kernel.org/all/20231204-const-sysctl-v2-0-7a5060b11447@wei=
ssschuh.net/

[8]
    #!/usr/bin/python3

    import subprocess
    import re

    def exec_cmd( cmd ):
        try:
            result =3D subprocess.run(cmd, shell=3DTrue, text=3DTrue, check=
=3DTrue, capture_output=3DTrue)
            output_lines =3D result.stdout.splitlines()
            return output_lines
        except Exception as e:
            print(f"An error occurred: {e}")
            return []

    def remove_tokens_re(lines, regex_patterns, uniq =3D True):
        filtered_lines =3D []
        seen_lines =3D set()
        regexes =3D [re.compile(pattern) for pattern in regex_patterns]

        for line in lines:
            for regex in regexes:
                line =3D regex.sub('', line)  # Replace matches with empty =
string

            if uniq:
                if line not in seen_lines:
                    seen_lines.add(line)
                    filtered_lines.append(line)
            else:
                    filtered_lines.append(line)

        return filtered_lines

    def filter_in_lines(lines, regex_patterns):
        filtered_lines =3D []
        regexes =3D [re.compile(pattern) for pattern in regex_patterns]

        for line in lines:
            if any(regex.search(line) for regex in regexes):
                filtered_lines.append(line)

        return filtered_lines

    cmd =3D "git grep 'static \(const \)\?struct ctl_table '"
    regex_patterns =3D ['[\}]*;$', ' =3D \{', '\[.*\]', '.*\.(c|h):[ \t]*st=
atic (const )?struct ctl_table ']
    ctl_table_structs =3D remove_tokens_re(exec_cmd( cmd ), regex_patterns)

    cmd =3D "readelf -X -Ws build/vmlinux"
    regex_patterns =3D ['.*OBJECT.*']
    output_lines =3D filter_in_lines(exec_cmd( cmd ), regex_patterns);

    regex_patterns =3D ['^.*OBJECT', '[ \t]+[A-Z]+[ \t]+[A-Z]+.*\(.*\)[ \t]=
+']
    obj_elems =3D remove_tokens_re( output_lines, regex_patterns, uniq=3DFa=
lse)

    regex_patterns =3D ['^.*\(', '\)[ ]+.*$']
    sec_names =3D remove_tokens_re( output_lines, regex_patterns, uniq=3DFa=
lse)

    for i in range(len(sec_names)):
        obj_name =3D obj_elems[i]
        if obj_name in ctl_table_structs:
            print ("section: {}\t\tobj_name : {}". format(sec_names[i], obj=
_name))

[9]
    section: .rodata                obj_name : kern_table
    section: .rodata                obj_name : sysctl_mount_point
    section: .rodata                obj_name : addrconf_sysctl
    section: .rodata                obj_name : ax25_param_table
    section: .rodata                obj_name : mpls_table
    section: .rodata                obj_name : mpls_dev_table
    section: .data          obj_name : sld_sysctls
    section: .data          obj_name : kern_panic_table
    section: .data          obj_name : kern_exit_table
    section: .data          obj_name : vm_table
    section: .data          obj_name : signal_debug_table
    section: .data          obj_name : usermodehelper_table
    section: .data          obj_name : kern_reboot_table
    section: .data          obj_name : user_table
    section: .bss           obj_name : sched_core_sysctls
    section: .data          obj_name : sched_fair_sysctls
    section: .data          obj_name : sched_rt_sysctls
    section: .data          obj_name : sched_dl_sysctls
    section: .data          obj_name : printk_sysctls
    section: .data          obj_name : pid_ns_ctl_table_vm
    section: .data          obj_name : seccomp_sysctl_table
    section: .data          obj_name : uts_kern_table
    section: .data          obj_name : vm_oom_kill_table
    section: .data          obj_name : vm_page_writeback_sysctls
    section: .data          obj_name : page_alloc_sysctl_table
    section: .data          obj_name : hugetlb_table
    section: .data          obj_name : fs_stat_sysctls
    section: .data          obj_name : fs_exec_sysctls
    section: .data          obj_name : fs_pipe_sysctls
    section: .data          obj_name : namei_sysctls
    section: .data          obj_name : fs_dcache_sysctls
    section: .data          obj_name : inodes_sysctls
    section: .data          obj_name : fs_namespace_sysctls
    section: .data          obj_name : dnotify_sysctls
    section: .data          obj_name : inotify_table
    section: .data          obj_name : epoll_table
    section: .data          obj_name : aio_sysctls
    section: .data          obj_name : locks_sysctls
    section: .data          obj_name : coredump_sysctls
    section: .data          obj_name : fs_shared_sysctls
    section: .data          obj_name : fs_dqstats_table
    section: .data          obj_name : root_table
    section: .data          obj_name : pty_table
    section: .data          obj_name : xfs_table
    section: .data          obj_name : ipc_sysctls
    section: .data          obj_name : key_sysctls
    section: .data          obj_name : kernel_io_uring_disabled_table
    section: .data          obj_name : tty_table
    section: .data          obj_name : random_table
    section: .data          obj_name : scsi_table
    section: .data          obj_name : iwcm_ctl_table
    section: .data          obj_name : net_core_table
    section: .data          obj_name : netns_core_table
    section: .bss           obj_name : nf_log_sysctl_table
    section: .data          obj_name : nf_log_sysctl_ftable
    section: .data          obj_name : vs_vars
    section: .data          obj_name : vs_vars_table
    section: .data          obj_name : ipv4_route_netns_table
    section: .data          obj_name : ipv4_route_table
    section: .data          obj_name : ip4_frags_ns_ctl_table
    section: .data          obj_name : ip4_frags_ctl_table
    section: .data          obj_name : ctl_forward_entry
    section: .data          obj_name : ipv4_table
    section: .data          obj_name : ipv4_net_table
    section: .data          obj_name : unix_table
    section: .data          obj_name : ipv6_route_table_template
    section: .data          obj_name : ipv6_icmp_table_template
    section: .data          obj_name : ip6_frags_ns_ctl_table
    section: .data          obj_name : ip6_frags_ctl_table
    section: .data          obj_name : ipv6_table_template
    section: .data          obj_name : ipv6_rotable
    section: .data          obj_name : sctp_net_table
    section: .data          obj_name : sctp_table
    section: .data          obj_name : smc_table
    section: .data          obj_name : lowpan_frags_ns_ctl_table
    section: .data          obj_name : lowpan_frags_ctl_table

--

Joel Granados

--pu6elde4hy573vso
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmY0qGMACgkQupfNUreW
QU9meQwAhSiWxhtL9djecqOkREsAyj1iIrA1uEV4NTghMsTyhC1r83HyDUEWGOJo
fTZ8jrYwxeDy9qnd5vC+hEYgx/tBWXv+79vssjd28m2Mn4DogQlWABKsPJlPw/8R
IB9dau7hME9YLSiZQaKoL8DuqnQ4jvdN/zvWcuYHl2s/jF+qzsI3DT4Dy98S1Sr8
63rSYg/sulLme7ov/3gAQ3ceSPYlLRUfYdWLlGkUYT2iIjcBIybKotaKGkERq8xL
Z2PcPpWj15gYh6Ewd0GL7AMq2M/dSGYYxPIbv0Mnjpe5AV5HzGZ06MUg4Tt11p1z
5Fchr0Hg24b2UYcx4mjbsDCy/OyF2oA8cjjj79ODXcgpsVxWX8GZdcFh/gNmsPw5
dKZyo4v1ZSvDmu8uDCcaV92GLelxc2YfGHYEfbE+hhJR0YaAukrL8mfqPJIanYv+
zzIuChlVlLB5xoY0CT3XgLo8NJrc/ERnY8JibAauNNLQvTjHV/tbd0UknFQQC4XL
gDaMqz5j
=1R4C
-----END PGP SIGNATURE-----

--pu6elde4hy573vso--

