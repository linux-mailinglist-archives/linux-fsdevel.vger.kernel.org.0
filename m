Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C395C3CEF40
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 00:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389646AbhGSVgT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jul 2021 17:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384535AbhGSSbO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jul 2021 14:31:14 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87AF8C061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jul 2021 12:01:46 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id j184so17789738qkd.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jul 2021 12:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=HpIVR41SNxxmrWQRPZx1Jc8kIHqT4zYLW1S+TZScing=;
        b=EKWC7HyDe1yb7k1ZElLzi1jjJHVyrpHbBo6xL9vTICFcPc5Cg4dtfBYmUOKqTm02zN
         kzofWlC/brSGeoi00EcZTIsvR8CoekX72V8ssgA8k+vf8OJNlZSF0g0ulOAtPzpZWFPD
         Z4JPmoSOXBoHUSQCxbdtMYYAXdBBtgBNwSuMS5dcwt+FoNUlgshudIQV1ZtRFGwsTLXj
         6XGcmZ4QEMPnSM/QULEiR2YXV36XwRRI7MxKmSZQOwahRkO1Zj5WkRr8ZHpW30gXVIXz
         CrMV1vM0kDJXrTjuS05ZtAZeyWrB7JbiCHkFS2/XSTC83rxcE8PyY8tWr6LzGmm41jKc
         QgOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=HpIVR41SNxxmrWQRPZx1Jc8kIHqT4zYLW1S+TZScing=;
        b=XOTk/4w8smqYKQx/EIk8eC/PKuugoMIgTepZrtrJhbXVKEO+FD0F8pJ7P3zdaQ7LIQ
         pyKv+3P/hKPaMQv5tDd8QC8hrskK72IVjkcbCMgQamesDh6i2GAJpondGCktwFMaufDq
         xLYUWI2tEuNhO4SyRhiXgxXVGa7eGIM4c1DgIrIT5mxMfknlRwmuBXu2sK24QgGlBUhG
         fL6Z3wk8xhyIFlL68uCj5XgLNyO6MerJ46z3hW3okX0RepOpI5FRFjeKcoK4VB1hYldg
         OlFVOUVHjesDUyX/0a3W1en+sy9F90mQBXnrQLKXp/ny6WXI/xCkKttsEaFRa0ljXbpq
         f7gQ==
X-Gm-Message-State: AOAM5323N4JyLU8O3akulPI9iBGNpoS2bmBrRjOE+efeNtPqxEYaUtvJ
        YBVBaOmdpYVDhLZTAq4Nq+8jng==
X-Google-Smtp-Source: ABdhPJyHpC+Qam/iW1OeJW20ZKqmuNIo1FjqlsVTttIiMWE6JjxW68cHDQi/pXp5liWKwHysIa9IGg==
X-Received: by 2002:a37:8e44:: with SMTP id q65mr26070129qkd.372.1626721910686;
        Mon, 19 Jul 2021 12:11:50 -0700 (PDT)
Received: from smtpclient.apple ([2600:1700:42f0:6600:ec90:c991:5957:a3db])
        by smtp.gmail.com with ESMTPSA id j2sm6276237qtn.46.2021.07.19.12.11.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Jul 2021 12:11:50 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [RESEND PATCH v2] hfsplus: prevent negative dentries when
 casefolded
From:   Viacheslav Dubeyko <slava@dubeyko.com>
In-Reply-To: <a2c84cfa-b6ed-c86c-0bb1-d05087c141d7@synology.com>
Date:   Mon, 19 Jul 2021 12:11:47 -0700
Cc:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        gustavoars@kernel.org, gregkh@linuxfoundation.org,
        keescook@chromium.org, mszeredi@redhat.com, shepjeng@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <E4E0A1E4-52A9-45D0-A179-B5289641FE22@dubeyko.com>
References: <20210716073635.1613671-1-cccheng@synology.com>
 <02B9566C-A78E-42FB-924B-A503E4BC6D2F@dubeyko.com>
 <a2c84cfa-b6ed-c86c-0bb1-d05087c141d7@synology.com>
To:     Chung-Chiang Cheng <cccheng@synology.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Jul 19, 2021, at 2:03 AM, Chung-Chiang Cheng <cccheng@synology.com> =
wrote:
>=20
> This function revalidates dentries without blocking and storing to the
> dentry. As the document mentioned [1], I think it's safe in rcu-walk
> mode. I also found jfs_ci_revalidate() takes the same approach.
>=20
>         d_revalidate may be called in rcu-walk mode (flags & =
LOOKUP_RCU).
>         If in rcu-walk mode, the filesystem must revalidate the dentry =
without
>         blocking or storing to the dentry, d_parent and d_inode should =
not be
>         used without care (because they can change and, in d_inode =
case, even
>         become NULL under us
>=20
>=20
> [1] https://www.kernel.org/doc/Documentation/filesystems/vfs.txt
>=20


I am still not convinced by the explanation.

>> This patch takes the same approach to drop negative dentires as vfat =
does.=20

You mentioned that you follows by vfat approach. But this code contains =
this code, as far as I can see. How could you prove that we will not =
introduce some weird bug here? What if code of this function will be =
changed in the future? I suppose that missing of this code could be the =
way to introduce some bug, anyway.

>> touch aaa
>> rm aaa
>> touch AAA

By the way, have you tested other possible combinations? I mean (1) =
=E2=80=98aaa=E2=80=99 -> =E2=80=98AAA=E2=80=99, (2) =E2=80=98AAA=E2=80=99 =
-> =E2=80=98aaa=E2=80=99, (3) =E2=80=98aaa=E2=80=99 -> =E2=80=98aaa=E2=80=99=
, (4) =E2=80=98AAA=E2=80=99 -> =E2=80=98AAA=E2=80=99. Could you please =
add in the comment that it was tested? Could we create the file in =
case-insensitive mode and, then, try to delete in case-sensitive and =
vise versa? Do we define this flag during volume creation? Can we change =
the flag by volume tuning?

Thanks,
Slava.


> Thanks,
> C.C.Cheng
>=20
>>> +
>>> +int hfsplus_revalidate_dentry(struct dentry *dentry, unsigned int =
flags)
>>> +{
>> What=E2=80=99s about this code?
>>=20
>> If (flags & LOOKUP_RCU)
>>    return -ECHILD;
>>=20
>> Do we really need to miss it here?
>>=20
>> Thanks,
>> Slava.
>>=20
>>=20
>>> +	/*
>>> +	 * dentries are always valid when disabling casefold.
>>> +	 */
>>> +	if (!test_bit(HFSPLUS_SB_CASEFOLD, =
&HFSPLUS_SB(dentry->d_sb)->flags))
>>> +		return 1;
>>> +
>>> +	/*
>>> +	 * Positive dentries are valid when enabling casefold.
>>> +	 *
>>> +	 * Note, rename() to existing directory entry will have =
->d_inode, and
>>> +	 * will use existing name which isn't specified name by user.
>>> +	 *
>>> +	 * We may be able to drop this positive dentry here. But =
dropping
>>> +	 * positive dentry isn't good idea. So it's unsupported like
>>> +	 * rename("filename", "FILENAME") for now.
>>> +	 */
>>> +	if (d_really_is_positive(dentry))
>>> +		return 1;
>>> +
>>> +	/*
>>> +	 * Drop the negative dentry, in order to make sure to use the =
case
>>> +	 * sensitive name which is specified by user if this is for =
creation.
>>> +	 */
>>> +	if (flags & (LOOKUP_CREATE | LOOKUP_RENAME_TARGET))
>>> +		return 0;
>>> +
>>> +	return 1;
>>> +}
>>> --=20
>>> 2.25.1
>>>=20

