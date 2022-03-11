Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3223B4D5E0C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Mar 2022 10:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244941AbiCKJFH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Mar 2022 04:05:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232954AbiCKJFG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Mar 2022 04:05:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF0E1BAF3F;
        Fri, 11 Mar 2022 01:04:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B18CEB82AE3;
        Fri, 11 Mar 2022 09:04:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C31FC340EC;
        Fri, 11 Mar 2022 09:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646989440;
        bh=OriMf86cJBQu679IJBUb+HY8GIZdI5iZ4EQ/25A+X84=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=GvDVzwwfhs5KcWSLTWj4Sgtq7tiD/xREwNpk+WmccwGCaU9J9jSRsHv+c2W3QiTRE
         tOjHvyuFtMjZ0UQWhomBFKzd1iwWpsYsc3HKsX/3ZUPQWNs//YF4ofw3JycfYGusjC
         6q7Ipl2OPqVoMBXLsqwcaIKymWglKEnxpKeLfwTOhpoIxe23HVBUPJL9VTa5n0LqTn
         jJLpTKoEz4hy2G+hUE/Cd/y63fiKlabnyY8hFUh0Ep/UB+z/hgogULT35jJgwo34wJ
         rLX2br3oHgv129jplaeCRhfFH0h8LKBU3xEDX3BiDAcWghgYrDDk0jAedLroxeZ1Gx
         fsGpxdYGrB9IQ==
Received: by mail-wm1-f51.google.com with SMTP id c192so4729137wma.4;
        Fri, 11 Mar 2022 01:04:00 -0800 (PST)
X-Gm-Message-State: AOAM5305ZcxPtvt61xs/3gZSDuQImW76jW54JnQTQgCF2BLY3RqdirQT
        /sAR7VSBmkGpanWuP0N1U2PU5hMSTn+XZS1Tld8=
X-Google-Smtp-Source: ABdhPJwTwbPDNlgEoT5zcrFQ1PEIkrTsZxCfj4DlIcWgY2MAdbBaOFHWG2esiKxSAqk8w9xlEOdyVpdFeb4v6PlJ3WA=
X-Received: by 2002:a05:600c:2141:b0:389:be5c:c764 with SMTP id
 v1-20020a05600c214100b00389be5cc764mr14744447wml.15.1646989438567; Fri, 11
 Mar 2022 01:03:58 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6000:1d93:0:0:0:0 with HTTP; Fri, 11 Mar 2022 01:03:57
 -0800 (PST)
In-Reply-To: <20220310210633.095f0245@suse.de>
References: <20220310142455.23127-1-vkarasulli@suse.de> <20220310142455.23127-3-vkarasulli@suse.de>
 <20220310210633.095f0245@suse.de>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Fri, 11 Mar 2022 18:03:57 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_ij3WqJHQZvH458XRwLBtboiJnr-fK0hVPDi_j_8XDZQ@mail.gmail.com>
Message-ID: <CAKYAXd_ij3WqJHQZvH458XRwLBtboiJnr-fK0hVPDi_j_8XDZQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] exfat currently unconditionally strips trailing
 periods '.' when performing path lookup, but allows them in the filenames
 during file creation. This is done intentionally, loosely following Windows
 behaviour and specifications which state:
To:     David Disseldorp <ddiss@suse.de>
Cc:     Vasant Karasulli <vkarasulli@suse.de>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Takashi Iwai <tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2022-03-11 5:06 GMT+09:00, David Disseldorp <ddiss@suse.de>:
> Thanks for reworking these changes, Vasant.
>
> Please trim the 1/2 and 2/2 patch subjects down to around 50 chars
> (including a "exfat: " prefix), with the details moved into the commit
> message body...
>
> On Thu, 10 Mar 2022 15:24:55 +0100, Vasant Karasulli wrote:
>
>>   #exFAT
>>   The concatenated file name has the same set of illegal characters as
>>   other FAT-based file systems (see Table 31).
>>
>>   #FAT
>>   ...
>>   Leading and trailing spaces in a long name are ignored.
>>   Leading and embedded periods are allowed in a name and are stored in
>>   the long name. Trailing periods are ignored.
>>
>> Note: Leading and trailing space ' ' characters are currently retained
>> by Linux kernel exfat, in conflict with the above specification.
>
> I think it makes sense to mention your findings from the Windows tests
> here. E.g. "Windows 10 also retains leading and trailing space
> characters".
Windows 10 do also strip them. So you can make another patch to strip
it as well as trailing periods.
>
>> Some implementations, such as fuse-exfat, don't perform path trailer
>> removal. When mounting images which contain trailing-dot paths, these
>> paths are unreachable, e.g.:
>>
>>   + mount.exfat-fuse /dev/zram0 /mnt/test/
>>   FUSE exfat 1.3.0
>>   + cd /mnt/test/
>>   + touch fuse_created_dots... '  fuse_created_spaces  '
>>   + ls -l
>>   total 0
>>   -rwxrwxrwx 1 root 0 0 Aug 18 09:45 '  fuse_created_spaces  '
>>   -rwxrwxrwx 1 root 0 0 Aug 18 09:45  fuse_created_dots...
>>   + cd /
>>   + umount /mnt/test/
>>   + mount -t exfat /dev/zram0 /mnt/test
>>   + cd /mnt/test
>>   + ls -l
>>   ls: cannot access 'fuse_created_dots...': No such file or directory
>>   total 0
>>   -rwxr-xr-x 1 root 0 0 Aug 18 09:45 '  fuse_created_spaces  '
>>   -????????? ? ?    ? ?            ?  fuse_created_dots...
>>   + touch kexfat_created_dots... '  kexfat_created_spaces  '
>>   + ls -l
>>   ls: cannot access 'fuse_created_dots...': No such file or directory
>>   total 0
>>   -rwxr-xr-x 1 root 0 0 Aug 18 09:45 '  fuse_created_spaces  '
>>   -rwxr-xr-x 1 root 0 0 Aug 18 09:45 '  kexfat_created_spaces  '
>>   -????????? ? ?    ? ?            ?  fuse_created_dots...
>>   -rwxr-xr-x 1 root 0 0 Aug 18 09:45  kexfat_created_dots
>>   + cd /
>>   + umount /mnt/test/
>>
>> With this change, the "keep_last_dots" mount option can be used to access
>> paths with trailing periods and disallow creating files with names with
>> trailing periods. E.g. continuing from the previous example:
>>
>>   + mount -t exfat -o keep_last_dots /dev/zram0 /mnt/test
>>   + cd /mnt/test
>>   + ls -l
>>   total 0
>>   -rwxr-xr-x 1 root 0 0 Aug 18 10:32 '  fuse_created_spaces  '
>>   -rwxr-xr-x 1 root 0 0 Aug 18 10:32 '  kexfat_created_spaces  '
>>   -rwxr-xr-x 1 root 0 0 Aug 18 10:32  fuse_created_dots...
>>   -rwxr-xr-x 1 root 0 0 Aug 18 10:32  kexfat_created_dots
>
> It'd be nice to demonstrate "keep_last_dots" creation here as well, e.g.
>
>   + echo > kexfat_created_dots_again...
>   sh: kexfat_created_dots_again...: Invalid argument
>
> @Namjae: not sure whether this is what you had in mind for preventing
> creation of invalid paths. What's your preference?
Look like what I wanted.

Thanks!
>
> Cheers, David
>
