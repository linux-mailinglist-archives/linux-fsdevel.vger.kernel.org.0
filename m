Return-Path: <linux-fsdevel+bounces-24191-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01AE593AF84
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2024 12:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 336B9B21DE4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2024 10:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD71155733;
	Wed, 24 Jul 2024 10:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FeTzLx5H";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6kEefEPX";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FeTzLx5H";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6kEefEPX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D7D156677;
	Wed, 24 Jul 2024 10:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721815221; cv=none; b=Sn/mxqs2RMIiAaQFGAEDhql5/Cg4KpqP2Y6m7k2p7vmM31q4C6z+JB2zFCsAb3sIaZTINPBuMpOS58xKBWAQMp+SpWLudI9WNOqRB5XQUxp9kRdAlyxh5tgr14Yh6EiULvSYoN0yoHbkyzUO+1KDMY4Udm2Ls+B4ljzpyIhmHX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721815221; c=relaxed/simple;
	bh=f10rItVYXRubfcNqUk0BXFInui1uuX+3y+ov42cbLQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c6eQfPFqD/8N/YfF0VqNXx2/HLxt+1oK5TM0MIWyxDcDQlFT+enVQrlodHSrPga89h6cd0Yx8k4B22s4h1gCjinLuE4KNy58FpJ+RK0QA0ZTeCbztNJ2LwhflaP4frrqJVPaInXSI2cOdFfuJw36VyqzamSMqtRJLo6vjjxrwMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FeTzLx5H; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6kEefEPX; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FeTzLx5H; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6kEefEPX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6394D1F799;
	Wed, 24 Jul 2024 10:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721815217; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TpLfdH0t/K9aVtW5Hspq7/+1p8nI88/qmSg6AYu2evQ=;
	b=FeTzLx5H23ADJfyUmR6RfFYZXHcJdY3qCpgZvgFNFrDsOFT5YWGixmTdFWQ/d4+0WtKqRJ
	DF2EL1sGNyFGmApkpLYVnoZcVjAf5aMQMXXfxJLeA4WZWkIVrDnuffL6yZ1z4ZrRI68nlB
	oHXYp8orn/bE9/urm/oYp8rQjtOJArw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721815217;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TpLfdH0t/K9aVtW5Hspq7/+1p8nI88/qmSg6AYu2evQ=;
	b=6kEefEPX2Gc5J+9oAgF5KLDNep/j4CcOBs0TfsO0xWnEAfEF5v3L2r+34wI/yblzFZQO5v
	9n6hlciM+Hr/oACw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721815217; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TpLfdH0t/K9aVtW5Hspq7/+1p8nI88/qmSg6AYu2evQ=;
	b=FeTzLx5H23ADJfyUmR6RfFYZXHcJdY3qCpgZvgFNFrDsOFT5YWGixmTdFWQ/d4+0WtKqRJ
	DF2EL1sGNyFGmApkpLYVnoZcVjAf5aMQMXXfxJLeA4WZWkIVrDnuffL6yZ1z4ZrRI68nlB
	oHXYp8orn/bE9/urm/oYp8rQjtOJArw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721815217;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TpLfdH0t/K9aVtW5Hspq7/+1p8nI88/qmSg6AYu2evQ=;
	b=6kEefEPX2Gc5J+9oAgF5KLDNep/j4CcOBs0TfsO0xWnEAfEF5v3L2r+34wI/yblzFZQO5v
	9n6hlciM+Hr/oACw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3B96613411;
	Wed, 24 Jul 2024 10:00:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id okKFDrHQoGa9XgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 24 Jul 2024 10:00:17 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D507FA0990; Wed, 24 Jul 2024 12:00:01 +0200 (CEST)
Date: Wed, 24 Jul 2024 12:00:01 +0200
From: Jan Kara <jack@suse.cz>
To: Julian Sun <sunjunchao2870@gmail.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, jack@suse.cz, brauner@kernel.org,
	viro@zeniv.linux.org.uk, masahiroy@kernel.org,
	akpm@linux-foundation.org, n.schier@avm.de, ojeda@kernel.org,
	djwong@kernel.org, kvalo@kernel.org
Subject: Re: [PATCH] scripts: add macro_checker script to check unused
 parameters in macros
Message-ID: <20240724100001.qdfexiwinuysqz7x@quack3>
References: <20240723091154.52458-1-sunjunchao2870@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240723091154.52458-1-sunjunchao2870@gmail.com>
X-Spamd-Result: default: False [-3.60 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.60

Hi!

On Tue 23-07-24 05:11:54, Julian Sun wrote:
> Recently, I saw a patch[1] on the ext4 mailing list regarding
> the correction of a macro definition error. Jan mentioned
> that "The bug in the macro is a really nasty trap...".
> Because existing compilers are unable to detect
> unused parameters in macro definitions. This inspired me
> to write a script to check for unused parameters in
> macro definitions and to run it.
> 
> Surprisingly, the script uncovered numerous issues across
> various subsystems, including filesystems, drivers, and sound etc.
> 
> Some of these issues involved parameters that were accepted
> but never used, for example:
> 	#define	XFS_DAENTER_DBS(mp,w)	\
> 	(XFS_DA_NODE_MAXDEPTH + (((w) == XFS_DATA_FORK) ? 2 : 0))
> where mp was unused.
> 
> While others are actual bugs.
> For example:
> 	#define HAL_SEQ_WCSS_UMAC_CE0_SRC_REG(x) \
> 		(ab->hw_params.regs->hal_seq_wcss_umac_ce0_src_reg)
> 	#define HAL_SEQ_WCSS_UMAC_CE0_DST_REG(x) \
> 		(ab->hw_params.regs->hal_seq_wcss_umac_ce0_dst_reg)
> 	#define HAL_SEQ_WCSS_UMAC_CE1_SRC_REG(x) \
> 		(ab->hw_params.regs->hal_seq_wcss_umac_ce1_src_reg)
> 	#define HAL_SEQ_WCSS_UMAC_CE1_DST_REG(x) \
> 		(ab->hw_params.regs->hal_seq_wcss_umac_ce1_dst_reg)
> where x was entirely unused, and instead, a local variable ab was used.
> 
> I have submitted patches[2-5] to fix some of these issues,
> but due to the large number, many still remain unaddressed.
> I believe that the kernel and matainers would benefit from
> this script to check for unused parameters in macro definitions.
> 
> It should be noted that it may cause some false positives
> in conditional compilation scenarios, such as
> 	#ifdef DEBUG
> 	static int debug(arg) {};
> 	#else
> 	#define debug(arg)
> 	#endif
> So the caller needs to manually verify whether it is a true
> issue. But this should be fine, because Maintainers should only
> need to review their own subsystems, which typically results
> in only a few reports.

Useful script! Thanks!

I think you could significantly reduce these false positives by checking
whether the macro definition ends up being empty, 0, or "do { } while (0)"
and in those cases don't issue a warning about unused arguments because it
is pretty much guaranteed the author meant it this way in these cases. You
seem to be already detecting the last pattern so adding the first two
should be easy.

								Honza

> 
> [1]: https://patchwork.ozlabs.org/project/linux-ext4/patch/1717652596-58760-1-git-send-email-carrionbent@linux.alibaba.com/
> [2]: https://lore.kernel.org/linux-xfs/20240721112701.212342-1-sunjunchao2870@gmail.com/
> [3]: https://lore.kernel.org/linux-bcachefs/20240721123943.246705-1-sunjunchao2870@gmail.com/
> [4]: https://sourceforge.net/p/linux-f2fs/mailman/message/58797811/
> [5]: https://sourceforge.net/p/linux-f2fs/mailman/message/58797812/
> 
> Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>
> ---
>  scripts/macro_checker.py | 101 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 101 insertions(+)
>  create mode 100755 scripts/macro_checker.py
> 
> diff --git a/scripts/macro_checker.py b/scripts/macro_checker.py
> new file mode 100755
> index 000000000000..cd10c9c10d31
> --- /dev/null
> +++ b/scripts/macro_checker.py
> @@ -0,0 +1,101 @@
> +#!/usr/bin/python3
> +# SPDX-License-Identifier: GPL-2.0
> +# Author: Julian Sun <sunjunchao2870@gmail.com>
> +
> +""" Find macro definitions with unused parameters. """
> +
> +import argparse
> +import os
> +import re
> +
> +macro_pattern = r"#define\s+(\w+)\(([^)]*)\)"
> +# below two vars were used to reduce false positives
> +do_while0_pattern = r"\s*do\s*\{\s*\}\s*while\s*\(\s*0\s*\)"
> +correct_macros = []
> +
> +def check_macro(macro_line, report):
> +    match = re.match(macro_pattern, macro_line)
> +    if match:
> +        macro_def = re.sub(macro_pattern, '', macro_line)
> +        identifier = match.group(1)
> +        content = match.group(2)
> +        arguments = [item.strip() for item in content.split(',') if item.strip()]
> +
> +        if (re.match(do_while0_pattern, macro_def)):
> +            return
> +
> +        for arg in arguments:
> +            # used to reduce false positives
> +            if "..." in arg:
> +                continue
> +            if not arg in macro_def and report == False:
> +                return
> +            if not arg in macro_def and identifier not in correct_macros:
> +                print(f"Argument {arg} is not used in function-line macro {identifier}")
> +                return
> +
> +        correct_macros.append(identifier)
> +
> +
> +# remove comment and whitespace
> +def macro_strip(macro):
> +    comment_pattern1 = r"\/\/*"
> +    comment_pattern2 = r"\/\**\*\/"
> +
> +    macro = macro.strip()
> +    macro = re.sub(comment_pattern1, '', macro)
> +    macro = re.sub(comment_pattern2, '', macro)
> +
> +    return macro
> +
> +def file_check_macro(file_path, report):
> +    # only check .c and .h file
> +    if not file_path.endswith(".c") and not file_path.endswith(".h"):
> +        return
> +
> +    with open(file_path, "r") as f:
> +        while True:
> +            line = f.readline()
> +            if not line:
> +                return
> +
> +            macro = re.match(macro_pattern, line)
> +            if macro:
> +                macro = macro_strip(macro.string)
> +                while macro[-1] == '\\':
> +                    macro = macro[0:-1]
> +                    macro = macro.strip()
> +                    macro += f.readline()
> +                    macro = macro_strip(macro)
> +                check_macro(macro, report)
> +
> +def get_correct_macros(path):
> +    file_check_macro(path, False)
> +
> +def dir_check_macro(dir_path):
> +
> +    for dentry in os.listdir(dir_path):
> +        path = os.path.join(dir_path, dentry)
> +        if os.path.isdir(path):
> +            dir_check_macro(path)
> +        elif os.path.isfile(path):
> +            get_correct_macros(path)
> +            file_check_macro(path, True)
> +
> +
> +def main():
> +    parser = argparse.ArgumentParser()
> +
> +    parser.add_argument("path", type=str, help="The file or dir path that needs check")
> +    args = parser.parse_args()
> +
> +    if os.path.isfile(args.path):
> +        get_correct_macros(args.path)
> +        file_check_macro(args.path, True)
> +    elif os.path.isdir(args.path):
> +        dir_check_macro(args.path)
> +    else:
> +        print(f"{args.path} doesn't exit or is neither a file nor a dir")
> +
> +if __name__ == "__main__":
> +    main()
> \ No newline at end of file
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

