Return-Path: <linux-fsdevel+bounces-24216-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 247FF93BA8B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 04:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63D48B22C13
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 02:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B311FC8F3;
	Thu, 25 Jul 2024 02:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gCO5qEXA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD7A1876;
	Thu, 25 Jul 2024 02:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721873551; cv=none; b=eY7XZUnvE5Wjc51eBXWEUlHvLDXx7+BUiNFSFx/hSW/2B9amZsPsekoISQjxXJFHWbIwGMmCKkyb2gTDocn6MWXqc8KXZsKXhneiGOEmbka9+YwdadXeNcS0XWonTeb8enERJ3iMUe2MBtslIazsJkDe5gBRkd+K1CcC4V2EWBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721873551; c=relaxed/simple;
	bh=TwAAHaebovm4UV86OQdph6KFtJ1zpDwUK7Rhpx86XFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rLuf7zpD14Ot5qTe2lTlfPHFtF0EwODm3WFyPDPtNM6pgsDj2lOvcq41UWWMcPlkeYPPz4RTCCz1ooUqKJwibrloWXcGyKvg4VVw4bFHlPS3Nv9+NU9zX7VlqS39r5+BTw3YPphlW6CRQjh94sa1CJKhHzyOE0I3LM/zlrJ0iFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gCO5qEXA; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5a2ffc34722so831669a12.0;
        Wed, 24 Jul 2024 19:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721873547; x=1722478347; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZSaEAhi3W4kaQGqTbLQhYLUILDWPa0M8QCanDq1rNdk=;
        b=gCO5qEXAdJ3QAVPodHVHALrQ8D2WBebDnmWKQ63HeyhN/pb0MM82j1xh83pDL4WFmX
         wbSWR1Mdat8nz3HV4GZtq9E51jNzedxgtXg4y4EImwE6rZ3ZMeDXH0CKD9oSjhKy6qtc
         IQGUDPLEUmfLakkmQelwk3OR2M96d29ziAmitr1Ljplk3g/rZ5+Gosm5N0Ofc71cNJM+
         2InqZyxL+U3N5qA0rszmZOTmULtE4/1MQ85Hb06vjsMXnKIcnRoFXWsjSilrpSc9uFNb
         L9C5q7aFHlrmSpxaDAKwt/qr/iwrEzOqogKueD0qJwi62ix00plIknDiWO/bhyPRL5xq
         lu7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721873547; x=1722478347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZSaEAhi3W4kaQGqTbLQhYLUILDWPa0M8QCanDq1rNdk=;
        b=TBJLdtGGoQz1aWq7ipVkPBOxx6i+bnHSntOnVx2/GWmTwWMD4YMontaasfc5pcWd8d
         AV0yLewOeAXenJxmDfrIm86YaX2flaBKkYIXjtPLdpVnkLn0ySHqPZF6LxFgSY80t38T
         KC2gtKROwoSasojdB/YmBm+sbTIyIsySxotxTiBMt/eHg7xUSbOV3eE4a2fyP2hnIwkR
         AAzf4byiAiFcup0vBOU+yYBK5Aj3aPB8LyJGXJPl4OTn3TDwQnTGf+1p+EuBeXKlX52S
         tkrlLiogIWsWso8gYSifD7AsrDOI2OqJdgtoDb+K0fwrKI9gGRIEzaXcVdRrWFt9JShF
         COvA==
X-Forwarded-Encrypted: i=1; AJvYcCVU3qEMaHrx3El+4poW181NEoDQypdiBgmzta/BELPyHCJ5MdhvXDRvONnCRa03ma0W7FYAJNm3Y9tnl8bGUsuQpGGQuV3A5NbHSX8O2NHy/KTz9+Dw5LGx6TNvonYUq6VE3Jd+Aak0/6xGhw==
X-Gm-Message-State: AOJu0YxOIEUZSYd10IU9ewfq5yNnDnXm2Fpbjz4CL24jz78puXKP8wVb
	A4vTsNNi0Hyhe9dBep6JdDVG/gh3dHdNrNIl9Bw4tomL/Yeh9/afDg+tT4fgmZq58CjipzaphrI
	mZ2hK9dNk/BpBUq2b48fBoYoT4Jg=
X-Google-Smtp-Source: AGHT+IH5kSSXFJ4NNPdpzvJbpbyJQqbidh/tlyFWA/KS67ZkLpP3G0QoDuGHfUyZfWTXwjPEGrPEa1+8t0bzjnB41ZM=
X-Received: by 2002:a50:8d5e:0:b0:58a:f14f:4d6d with SMTP id
 4fb4d7f45d1cf-5ab1bd5a62fmr3396853a12.19.1721873547280; Wed, 24 Jul 2024
 19:12:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240723091154.52458-1-sunjunchao2870@gmail.com> <20240724100001.qdfexiwinuysqz7x@quack3>
In-Reply-To: <20240724100001.qdfexiwinuysqz7x@quack3>
From: Julian Sun <sunjunchao2870@gmail.com>
Date: Wed, 24 Jul 2024 22:12:13 -0400
Message-ID: <CAHB1NaiaaTyS1jpX4cm-CP-0-sT7botDUNoob1SHVmDw2qF49w@mail.gmail.com>
Subject: Re: [PATCH] scripts: add macro_checker script to check unused
 parameters in macros
To: Jan Kara <jack@suse.cz>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, brauner@kernel.org, viro@zeniv.linux.org.uk, 
	masahiroy@kernel.org, akpm@linux-foundation.org, n.schier@avm.de, 
	ojeda@kernel.org, djwong@kernel.org, kvalo@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jan Kara <jack@suse.cz> =E4=BA=8E2024=E5=B9=B47=E6=9C=8824=E6=97=A5=E5=91=
=A8=E4=B8=89 06:00=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi!
>
> On Tue 23-07-24 05:11:54, Julian Sun wrote:
> > Recently, I saw a patch[1] on the ext4 mailing list regarding
> > the correction of a macro definition error. Jan mentioned
> > that "The bug in the macro is a really nasty trap...".
> > Because existing compilers are unable to detect
> > unused parameters in macro definitions. This inspired me
> > to write a script to check for unused parameters in
> > macro definitions and to run it.
> >
> > Surprisingly, the script uncovered numerous issues across
> > various subsystems, including filesystems, drivers, and sound etc.
> >
> > Some of these issues involved parameters that were accepted
> > but never used, for example:
> >       #define XFS_DAENTER_DBS(mp,w)   \
> >       (XFS_DA_NODE_MAXDEPTH + (((w) =3D=3D XFS_DATA_FORK) ? 2 : 0))
> > where mp was unused.
> >
> > While others are actual bugs.
> > For example:
> >       #define HAL_SEQ_WCSS_UMAC_CE0_SRC_REG(x) \
> >               (ab->hw_params.regs->hal_seq_wcss_umac_ce0_src_reg)
> >       #define HAL_SEQ_WCSS_UMAC_CE0_DST_REG(x) \
> >               (ab->hw_params.regs->hal_seq_wcss_umac_ce0_dst_reg)
> >       #define HAL_SEQ_WCSS_UMAC_CE1_SRC_REG(x) \
> >               (ab->hw_params.regs->hal_seq_wcss_umac_ce1_src_reg)
> >       #define HAL_SEQ_WCSS_UMAC_CE1_DST_REG(x) \
> >               (ab->hw_params.regs->hal_seq_wcss_umac_ce1_dst_reg)
> > where x was entirely unused, and instead, a local variable ab was used.
> >
> > I have submitted patches[2-5] to fix some of these issues,
> > but due to the large number, many still remain unaddressed.
> > I believe that the kernel and matainers would benefit from
> > this script to check for unused parameters in macro definitions.
> >
> > It should be noted that it may cause some false positives
> > in conditional compilation scenarios, such as
> >       #ifdef DEBUG
> >       static int debug(arg) {};
> >       #else
> >       #define debug(arg)
> >       #endif
> > So the caller needs to manually verify whether it is a true
> > issue. But this should be fine, because Maintainers should only
> > need to review their own subsystems, which typically results
> > in only a few reports.
>
> Useful script! Thanks!
>
>
> > I think you could significantly reduce these false positives by checkin=
g
> > whether the macro definition ends up being empty, 0, or "do { } while (=
0)"
> > and in those cases don't issue a warning about unused arguments because=
 it
> > is pretty much guaranteed the author meant it this way in these cases. =
You
> > seem to be already detecting the last pattern so adding the first two
> > should be easy.
Great suggestion! I will refine this script and send patch v2.
Thanks for you suggestion, Jan.
>
>                                                                 Honza
>
> >
> > [1]: https://patchwork.ozlabs.org/project/linux-ext4/patch/1717652596-5=
8760-1-git-send-email-carrionbent@linux.alibaba.com/
> > [2]: https://lore.kernel.org/linux-xfs/20240721112701.212342-1-sunjunch=
ao2870@gmail.com/
> > [3]: https://lore.kernel.org/linux-bcachefs/20240721123943.246705-1-sun=
junchao2870@gmail.com/
> > [4]: https://sourceforge.net/p/linux-f2fs/mailman/message/58797811/
> > [5]: https://sourceforge.net/p/linux-f2fs/mailman/message/58797812/
> >
> > Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>
> > ---
> >  scripts/macro_checker.py | 101 +++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 101 insertions(+)
> >  create mode 100755 scripts/macro_checker.py
> >
> > diff --git a/scripts/macro_checker.py b/scripts/macro_checker.py
> > new file mode 100755
> > index 000000000000..cd10c9c10d31
> > --- /dev/null
> > +++ b/scripts/macro_checker.py
> > @@ -0,0 +1,101 @@
> > +#!/usr/bin/python3
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Author: Julian Sun <sunjunchao2870@gmail.com>
> > +
> > +""" Find macro definitions with unused parameters. """
> > +
> > +import argparse
> > +import os
> > +import re
> > +
> > +macro_pattern =3D r"#define\s+(\w+)\(([^)]*)\)"
> > +# below two vars were used to reduce false positives
> > +do_while0_pattern =3D r"\s*do\s*\{\s*\}\s*while\s*\(\s*0\s*\)"
> > +correct_macros =3D []
> > +
> > +def check_macro(macro_line, report):
> > +    match =3D re.match(macro_pattern, macro_line)
> > +    if match:
> > +        macro_def =3D re.sub(macro_pattern, '', macro_line)
> > +        identifier =3D match.group(1)
> > +        content =3D match.group(2)
> > +        arguments =3D [item.strip() for item in content.split(',') if =
item.strip()]
> > +
> > +        if (re.match(do_while0_pattern, macro_def)):
> > +            return
> > +
> > +        for arg in arguments:
> > +            # used to reduce false positives
> > +            if "..." in arg:
> > +                continue
> > +            if not arg in macro_def and report =3D=3D False:
> > +                return
> > +            if not arg in macro_def and identifier not in correct_macr=
os:
> > +                print(f"Argument {arg} is not used in function-line ma=
cro {identifier}")
> > +                return
> > +
> > +        correct_macros.append(identifier)
> > +
> > +
> > +# remove comment and whitespace
> > +def macro_strip(macro):
> > +    comment_pattern1 =3D r"\/\/*"
> > +    comment_pattern2 =3D r"\/\**\*\/"
> > +
> > +    macro =3D macro.strip()
> > +    macro =3D re.sub(comment_pattern1, '', macro)
> > +    macro =3D re.sub(comment_pattern2, '', macro)
> > +
> > +    return macro
> > +
> > +def file_check_macro(file_path, report):
> > +    # only check .c and .h file
> > +    if not file_path.endswith(".c") and not file_path.endswith(".h"):
> > +        return
> > +
> > +    with open(file_path, "r") as f:
> > +        while True:
> > +            line =3D f.readline()
> > +            if not line:
> > +                return
> > +
> > +            macro =3D re.match(macro_pattern, line)
> > +            if macro:
> > +                macro =3D macro_strip(macro.string)
> > +                while macro[-1] =3D=3D '\\':
> > +                    macro =3D macro[0:-1]
> > +                    macro =3D macro.strip()
> > +                    macro +=3D f.readline()
> > +                    macro =3D macro_strip(macro)
> > +                check_macro(macro, report)
> > +
> > +def get_correct_macros(path):
> > +    file_check_macro(path, False)
> > +
> > +def dir_check_macro(dir_path):
> > +
> > +    for dentry in os.listdir(dir_path):
> > +        path =3D os.path.join(dir_path, dentry)
> > +        if os.path.isdir(path):
> > +            dir_check_macro(path)
> > +        elif os.path.isfile(path):
> > +            get_correct_macros(path)
> > +            file_check_macro(path, True)
> > +
> > +
> > +def main():
> > +    parser =3D argparse.ArgumentParser()
> > +
> > +    parser.add_argument("path", type=3Dstr, help=3D"The file or dir pa=
th that needs check")
> > +    args =3D parser.parse_args()
> > +
> > +    if os.path.isfile(args.path):
> > +        get_correct_macros(args.path)
> > +        file_check_macro(args.path, True)
> > +    elif os.path.isdir(args.path):
> > +        dir_check_macro(args.path)
> > +    else:
> > +        print(f"{args.path} doesn't exit or is neither a file nor a di=
r")
> > +
> > +if __name__ =3D=3D "__main__":
> > +    main()
> > \ No newline at end of file
> > --
> > 2.39.2
> >
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR


Thanks,
--=20
Julian Sun <sunjunchao2870@gmail.com>

