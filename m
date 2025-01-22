Return-Path: <linux-fsdevel+bounces-39884-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0314DA19B95
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 00:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31E3516B50F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 23:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87561CDFBC;
	Wed, 22 Jan 2025 23:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B1q2kd5w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375AE1CAA86;
	Wed, 22 Jan 2025 23:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737589757; cv=none; b=f2ReD45/P9JC7g99FELuZMzqFWSoTO/+//9BAMnfGUItYr63Td5RvN4mqnznHVCUR860Fs/NsERgkeCf1GpUBkeQJv4ePHIIpYJTmr7bPmegs7TFWjYY8VPNG0/rk0bV5XtxnZ3b8InHca+SuJuDfRPafjuQdXrdnqG7jWxpXZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737589757; c=relaxed/simple;
	bh=knU8Gb3CdvkSEet5faVhn1gPZtISfXDqOx7vpI3Dd2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PBVPVediqgyjRQgSRlwy5dxI9MQoJ1wPFjm9Sl1QrvfPsK4voLuMxe14i0Ye4/J3dXoyWfHIqTt01l6WVht7VzflvZTohcfyi5EHDBK5LqGG0Y8Vlxwa3Uvraj6TPNF2s07KJTLxQ/S/ZRvOMLxebfb8rDQPoQfgvCh8LppUqOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B1q2kd5w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8380C4CEE3;
	Wed, 22 Jan 2025 23:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737589756;
	bh=knU8Gb3CdvkSEet5faVhn1gPZtISfXDqOx7vpI3Dd2k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=B1q2kd5wpykV33KapdmKwzsKBYSgxv7Mx3Yyzrf6nDU7vJcc4TDUL+vWg9kKA4aDP
	 5AupA2AEzCvsuIWlbmiq6+PVB+WLI6O9DkOq8jE0TRM55zcpicau7uMja7ftpU1KfH
	 kpcutyqIHVJeb39lMIteKODJan6z7KuKX5h9qjdYht0HnAXJlPLnPH9ssN8UwfeJBc
	 q1b0ua9ZGZm/PzuqpWeEaxO9JZdeOkiuuGtfZjzf44nEsVlCj+5fsQbCpZSGYyAvis
	 95NRhJFRuCWM0PKqQtTc+DG51kdKgzc7D9g1ho1w/ajQ/MhXoDPSuPNpA83593a9Tw
	 4jPRztV9yvNiQ==
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3eb790888c6so98900b6e.2;
        Wed, 22 Jan 2025 15:49:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUm77AzJs/mre+uuZSGtIGjwEZHqEFtFt9HiHTviJ84II1wRtzICy0h28Nw4doP6qFrx4zO9mTdwF+cMdNA@vger.kernel.org, AJvYcCWTf/WvQdVjPTRrT7dsHI8cL9IpsajG1r6Qm4HlBzh0+uvFTi9fLRUTzeeBTj/B7ilmhPvRQkFZQ5VyGc+8@vger.kernel.org
X-Gm-Message-State: AOJu0YybFmj06EIwht5NT5alE93yjnn+JtBbZir64+aiKOOtkKpgB4c3
	9Rd06OqsAXgS5432aUW/5i6N/rZ51tLJGJfALZlSpKXh8usuESDDlwG6ivIoExpOUdbt4/H2rfE
	Rn7RweShIG3xNCpv9rVl/e0VQJnw=
X-Google-Smtp-Source: AGHT+IGaFRdxFjJzs39uci0qiDE0VPxhsx4BPJpByGZpoLIH3d2rku9XooiQ/2aWnb95Ls5gqdBdrY2nfDnRumf2NYw=
X-Received: by 2002:a05:6808:1b90:b0:3e4:d4ca:2774 with SMTP id
 5614622812f47-3f19fca5ff1mr15639036b6e.20.1737589755954; Wed, 22 Jan 2025
 15:49:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8F76A19F-2EFD-4DD4-A4B1-9F5C644B69EA@m.fudan.edu.cn>
 <04205AC4-F899-4FA0-A7C1-9B1D661EB4EA@m.fudan.edu.cn> <CAKYAXd_Zs4r2aX4M0DDQe2oYQaUwKrPq_qoNKj4kBFTSC2ynpg@mail.gmail.com>
 <C2EE930A-5B60-4DB7-861A-3CE836560E94@m.fudan.edu.cn> <CAKYAXd-6d2LCWJQkuc8=EdJbHi=gea=orvm_BmXTMXaQ2w8AHg@mail.gmail.com>
 <79CFA11A-DD34-46B4-8425-74B933ADF447@m.fudan.edu.cn>
In-Reply-To: <79CFA11A-DD34-46B4-8425-74B933ADF447@m.fudan.edu.cn>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 23 Jan 2025 08:49:04 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_ebG4L_mRwCqoGgt9kQ6BxcCf6M5UUJ1djnbMkBLUbgg@mail.gmail.com>
X-Gm-Features: AbW1kvau7LagfwQw705K4p4RwkzIMOW-a_a1W6Ejg6EDHvd1frLmKkQgp2YWnss
Message-ID: <CAKYAXd_ebG4L_mRwCqoGgt9kQ6BxcCf6M5UUJ1djnbMkBLUbgg@mail.gmail.com>
Subject: Re: Bug: soft lockup in exfat_clear_bitmap
To: Kun Hu <huk23@m.fudan.edu.cn>
Cc: Sungjong Seo <sj1557.seo@samsung.com>, "Yuezhang.Mo" <yuezhang.mo@sony.com>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, jjtan24@m.fudan.edu.cn
Content-Type: multipart/mixed; boundary="0000000000002b98ed062c54246a"

--0000000000002b98ed062c54246a
Content-Type: multipart/alternative; boundary="0000000000002b98ea062c542468"

--0000000000002b98ea062c542468
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 10:16=E2=80=AFPM Kun Hu <huk23@m.fudan.edu.cn> wrot=
e:
>
>
> > This is an already known issue and the relevant patch has been applied.
> > Please make sure that the following patch is applied to the kernel you
tested.
> >
> > a5324b3a488d exfat: fix the infinite loop in __exfat_free_cluster()
> >
> > or try to reproduce it with linux-6.13-rc7.
>
> Hi Namjae,
Hi Kun,
>
> We still successfully reproduced it on the v6.13-rc7. Firstly, I
apologize for taking up your time, I=E2=80=99m not sure if this is a signif=
icant
issue since from the reproducer it kind of looks like it=E2=80=99s caused v=
ia fault
injection.
>
>
> The syz_mount_image in the syscall reproducer mounts a randomly generated
image and also has the potential to trigger an abnormal path to the file
system. Specifically, the . /file0 file is crafted to contain invalid FAT
table or bitmap information, it is possible to cause abnormal cyclic
behavior in __exfat_free_cluster.
>
> Because p_chain->size is artificially constructed, if it has a large
value, then exfat_clear_bitmap will be called frequently. As the call stack
shows, the program eventually deadlocks in the loop in __exfat_free_cluster=
.
>
> This link is a link to our crash log in the rc7 kernel tree:
>
> Link:
https://github.com/pghk13/Kernel-Bug/blob/main/0103_6.13rc5_%E6%9C%AA%E6%8A=
%A5%E5%91%8A/%E6%9C%89%E7%9B%B8%E4%BC%BC%E6%A3%80%E7%B4%A2%E8%AE%B0%E5%BD%9=
5/39-BUG_%20soft%20lockup%20in%20sys_unlink/crashlog0115_rc7.txt
>
> As I said earlier, I'm still consistently reporting the crash I found to
you guys now because I'm not sure if this issue is useful to you. If it is
not useful, please ignore it. I hope it doesn't take up too much of your
time.
Can you check an attached patch ?

Thanks.
>
> =E2=80=94=E2=80=94=E2=80=94
> Kun Hu
>
>

--0000000000002b98ea062c542468
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">On Wed, Jan 15, 2025 at 10:16=E2=80=AFPM Kun Hu &lt;<a hr=
ef=3D"mailto:huk23@m.fudan.edu.cn" target=3D"_blank" rel=3D"noreferrer">huk=
23@m.fudan.edu.cn</a>&gt; wrote:<br>
&gt;<br>
&gt;<br>
&gt; &gt; This is an already known issue and the relevant patch has been ap=
plied.<br>
&gt; &gt; Please make sure that the following patch is applied to the kerne=
l you tested.<br>
&gt; &gt;<br>
&gt; &gt; a5324b3a488d exfat: fix the infinite loop in __exfat_free_cluster=
()<br>
&gt; &gt;<br>
&gt; &gt; or try to reproduce it with linux-6.13-rc7.<br>
&gt;<br>
&gt; Hi Namjae,<br>
Hi Kun,<br>
&gt;<br>
&gt; We still successfully reproduced it on the v6.13-rc7. Firstly, I apolo=
gize for taking up your time, I=E2=80=99m not sure if this is a significant=
 issue since from the reproducer it kind of looks like it=E2=80=99s caused =
via fault injection.<br>
&gt;<br>
&gt;<br>
&gt; The syz_mount_image in the syscall reproducer mounts a randomly genera=
ted image and also has the potential to trigger an abnormal path to the fil=
e system. Specifically, the . /file0 file is crafted to contain invalid FAT=
 table or bitmap information, it is possible to cause abnormal cyclic behav=
ior in __exfat_free_cluster.<br>
&gt;<br>
&gt; Because p_chain-&gt;size is artificially constructed, if it has a larg=
e value, then exfat_clear_bitmap will be called frequently. As the call sta=
ck shows, the program eventually deadlocks in the loop in __exfat_free_clus=
ter.<br>
&gt;<br>
&gt; This link is a link to our crash log in the rc7 kernel tree:<br>
&gt;<br>
&gt; Link: <a href=3D"https://github.com/pghk13/Kernel-Bug/blob/main/0103_6=
.13rc5_%E6%9C%AA%E6%8A%A5%E5%91%8A/%E6%9C%89%E7%9B%B8%E4%BC%BC%E6%A3%80%E7%=
B4%A2%E8%AE%B0%E5%BD%95/39-BUG_%20soft%20lockup%20in%20sys_unlink/crashlog0=
115_rc7.txt" rel=3D"noreferrer noreferrer" target=3D"_blank">https://github=
.com/pghk13/Kernel-Bug/blob/main/0103_6.13rc5_%E6%9C%AA%E6%8A%A5%E5%91%8A/%=
E6%9C%89%E7%9B%B8%E4%BC%BC%E6%A3%80%E7%B4%A2%E8%AE%B0%E5%BD%95/39-BUG_%20so=
ft%20lockup%20in%20sys_unlink/crashlog0115_rc7.txt</a><br>
&gt;<br>
&gt; As I said earlier, I&#39;m still consistently reporting the crash I fo=
und to you guys now because I&#39;m not sure if this issue is useful to you=
. If it is not useful, please ignore it. I hope it doesn&#39;t take up too =
much of your time.<br>
Can you check an attached patch ?<br>
<br>
Thanks.<br>
&gt;<br>
&gt; =E2=80=94=E2=80=94=E2=80=94<br>
&gt; Kun Hu<br>
&gt;<br>
&gt;<br></div>

--0000000000002b98ea062c542468--
--0000000000002b98ed062c54246a
Content-Type: application/x-patch; name="0001-exfat-fix-infinite-loop.patch"
Content-Disposition: attachment; 
	filename="0001-exfat-fix-infinite-loop.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m66mrtnm0>
X-Attachment-Id: f_m66mrtnm0

RnJvbSAwYmIyNmFjNmFhNjVjOWQ5ZDQxZjE5YWYzMDVmYjcyYzQ4MGZkMWQ2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBOYW1qYWUgSmVvbiA8bGlua2luamVvbkBrZXJuZWwub3JnPgpE
YXRlOiBXZWQsIDIyIEphbiAyMDI1IDAwOjI0OjMxICswOTAwClN1YmplY3Q6IFtQQVRDSF0gZXhm
YXQ6IGZpeCBpbmZpbml0ZSBsb29wCgpTaWduZWQtb2ZmLWJ5OiBOYW1qYWUgSmVvbiA8bGlua2lu
amVvbkBrZXJuZWwub3JnPgotLS0KIGZzL2V4ZmF0L2JhbGxvYy5jICAgfCAxMCArKysrKysrKy0t
CiBmcy9leGZhdC9leGZhdF9mcy5oIHwgIDIgKy0KIGZzL2V4ZmF0L2ZhdGVudC5jICAgfCAgOCAr
KysrKy0tLQogMyBmaWxlcyBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygt
KQoKZGlmZiAtLWdpdCBhL2ZzL2V4ZmF0L2JhbGxvYy5jIGIvZnMvZXhmYXQvYmFsbG9jLmMKaW5k
ZXggY2U5YmU5NWM5MTcyLi45ZmY4MjVmMTUwMmQgMTAwNjQ0Ci0tLSBhL2ZzL2V4ZmF0L2JhbGxv
Yy5jCisrKyBiL2ZzL2V4ZmF0L2JhbGxvYy5jCkBAIC0xNDEsNyArMTQxLDcgQEAgaW50IGV4ZmF0
X3NldF9iaXRtYXAoc3RydWN0IGlub2RlICppbm9kZSwgdW5zaWduZWQgaW50IGNsdSwgYm9vbCBz
eW5jKQogCXJldHVybiAwOwogfQogCi12b2lkIGV4ZmF0X2NsZWFyX2JpdG1hcChzdHJ1Y3QgaW5v
ZGUgKmlub2RlLCB1bnNpZ25lZCBpbnQgY2x1LCBib29sIHN5bmMpCitpbnQgZXhmYXRfY2xlYXJf
Yml0bWFwKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHVuc2lnbmVkIGludCBjbHUsIGJvb2wgc3luYykK
IHsKIAlpbnQgaSwgYjsKIAl1bnNpZ25lZCBpbnQgZW50X2lkeDsKQEAgLTE1MCwxMyArMTUwLDE3
IEBAIHZvaWQgZXhmYXRfY2xlYXJfYml0bWFwKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHVuc2lnbmVk
IGludCBjbHUsIGJvb2wgc3luYykKIAlzdHJ1Y3QgZXhmYXRfbW91bnRfb3B0aW9ucyAqb3B0cyA9
ICZzYmktPm9wdGlvbnM7CiAKIAlpZiAoIWlzX3ZhbGlkX2NsdXN0ZXIoc2JpLCBjbHUpKQotCQly
ZXR1cm47CisJCXJldHVybiAtRUlPOwogCiAJZW50X2lkeCA9IENMVVNURVJfVE9fQklUTUFQX0VO
VChjbHUpOwogCWkgPSBCSVRNQVBfT0ZGU0VUX1NFQ1RPUl9JTkRFWChzYiwgZW50X2lkeCk7CiAJ
YiA9IEJJVE1BUF9PRkZTRVRfQklUX0lOX1NFQ1RPUihzYiwgZW50X2lkeCk7CiAKKwlpZiAoIXRl
c3RfYml0X2xlKGIsIHNiaS0+dm9sX2FtYXBbaV0tPmJfZGF0YSkpCisJCXJldHVybiAtRUlPOwor
CiAJY2xlYXJfYml0X2xlKGIsIHNiaS0+dm9sX2FtYXBbaV0tPmJfZGF0YSk7CisKIAlleGZhdF91
cGRhdGVfYmgoc2JpLT52b2xfYW1hcFtpXSwgc3luYyk7CiAKIAlpZiAob3B0cy0+ZGlzY2FyZCkg
ewpAQCAtMTcxLDYgKzE3NSw4IEBAIHZvaWQgZXhmYXRfY2xlYXJfYml0bWFwKHN0cnVjdCBpbm9k
ZSAqaW5vZGUsIHVuc2lnbmVkIGludCBjbHUsIGJvb2wgc3luYykKIAkJCW9wdHMtPmRpc2NhcmQg
PSAwOwogCQl9CiAJfQorCisJcmV0dXJuIDA7CiB9CiAKIC8qCmRpZmYgLS1naXQgYS9mcy9leGZh
dC9leGZhdF9mcy5oIGIvZnMvZXhmYXQvZXhmYXRfZnMuaAppbmRleCA3OGJlNjk2NGE4YTAuLmQz
MGNlMThhODhiNyAxMDA2NDQKLS0tIGEvZnMvZXhmYXQvZXhmYXRfZnMuaAorKysgYi9mcy9leGZh
dC9leGZhdF9mcy5oCkBAIC00NTYsNyArNDU2LDcgQEAgaW50IGV4ZmF0X2NvdW50X251bV9jbHVz
dGVycyhzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiLAogaW50IGV4ZmF0X2xvYWRfYml0bWFwKHN0cnVj
dCBzdXBlcl9ibG9jayAqc2IpOwogdm9pZCBleGZhdF9mcmVlX2JpdG1hcChzdHJ1Y3QgZXhmYXRf
c2JfaW5mbyAqc2JpKTsKIGludCBleGZhdF9zZXRfYml0bWFwKHN0cnVjdCBpbm9kZSAqaW5vZGUs
IHVuc2lnbmVkIGludCBjbHUsIGJvb2wgc3luYyk7Ci12b2lkIGV4ZmF0X2NsZWFyX2JpdG1hcChz
dHJ1Y3QgaW5vZGUgKmlub2RlLCB1bnNpZ25lZCBpbnQgY2x1LCBib29sIHN5bmMpOworaW50IGV4
ZmF0X2NsZWFyX2JpdG1hcChzdHJ1Y3QgaW5vZGUgKmlub2RlLCB1bnNpZ25lZCBpbnQgY2x1LCBi
b29sIHN5bmMpOwogdW5zaWduZWQgaW50IGV4ZmF0X2ZpbmRfZnJlZV9iaXRtYXAoc3RydWN0IHN1
cGVyX2Jsb2NrICpzYiwgdW5zaWduZWQgaW50IGNsdSk7CiBpbnQgZXhmYXRfY291bnRfdXNlZF9j
bHVzdGVycyhzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiLCB1bnNpZ25lZCBpbnQgKnJldF9jb3VudCk7
CiBpbnQgZXhmYXRfdHJpbV9mcyhzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3QgZnN0cmltX3Jh
bmdlICpyYW5nZSk7CmRpZmYgLS1naXQgYS9mcy9leGZhdC9mYXRlbnQuYyBiL2ZzL2V4ZmF0L2Zh
dGVudC5jCmluZGV4IDllNTQ5MmFjNDA5Yi4uOGQ3OGIzMDMwNTc1IDEwMDY0NAotLS0gYS9mcy9l
eGZhdC9mYXRlbnQuYworKysgYi9mcy9leGZhdC9mYXRlbnQuYwpAQCAtMTc1LDYgKzE3NSw3IEBA
IHN0YXRpYyBpbnQgX19leGZhdF9mcmVlX2NsdXN0ZXIoc3RydWN0IGlub2RlICppbm9kZSwgc3Ry
dWN0IGV4ZmF0X2NoYWluICpwX2NoYWluCiAJCUJJVE1BUF9PRkZTRVRfU0VDVE9SX0lOREVYKHNi
LCBDTFVTVEVSX1RPX0JJVE1BUF9FTlQoY2x1KSk7CiAKIAlpZiAocF9jaGFpbi0+ZmxhZ3MgPT0g
QUxMT0NfTk9fRkFUX0NIQUlOKSB7CisJCWludCBlcnI7CiAJCXVuc2lnbmVkIGludCBsYXN0X2Ns
dXN0ZXIgPSBwX2NoYWluLT5kaXIgKyBwX2NoYWluLT5zaXplIC0gMTsKIAkJZG8gewogCQkJYm9v
bCBzeW5jID0gZmFsc2U7CkBAIC0xODksNyArMTkwLDkgQEAgc3RhdGljIGludCBfX2V4ZmF0X2Zy
ZWVfY2x1c3RlcihzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3QgZXhmYXRfY2hhaW4gKnBfY2hh
aW4KIAkJCQljdXJfY21hcF9pID0gbmV4dF9jbWFwX2k7CiAJCQl9CiAKLQkJCWV4ZmF0X2NsZWFy
X2JpdG1hcChpbm9kZSwgY2x1LCAoc3luYyAmJiBJU19ESVJTWU5DKGlub2RlKSkpOworCQkJZXJy
ID0gZXhmYXRfY2xlYXJfYml0bWFwKGlub2RlLCBjbHUsIChzeW5jICYmIElTX0RJUlNZTkMoaW5v
ZGUpKSk7CisJCQlpZiAoZXJyKQorCQkJCWJyZWFrOwogCQkJY2x1Kys7CiAJCQludW1fY2x1c3Rl
cnMrKzsKIAkJfSB3aGlsZSAobnVtX2NsdXN0ZXJzIDwgcF9jaGFpbi0+c2l6ZSk7CkBAIC0yMTUs
NyArMjE4LDcgQEAgc3RhdGljIGludCBfX2V4ZmF0X2ZyZWVfY2x1c3RlcihzdHJ1Y3QgaW5vZGUg
Kmlub2RlLCBzdHJ1Y3QgZXhmYXRfY2hhaW4gKnBfY2hhaW4KIAkJCW51bV9jbHVzdGVycysrOwog
CiAJCQlpZiAoZXJyKQotCQkJCWdvdG8gZGVjX3VzZWRfY2x1czsKKwkJCQlicmVhazsKIAogCQkJ
aWYgKG51bV9jbHVzdGVycyA+PSBzYmktPm51bV9jbHVzdGVycyAtIEVYRkFUX0ZJUlNUX0NMVVNU
RVIpIHsKIAkJCQkvKgpAQCAtMjI5LDcgKzIzMiw2IEBAIHN0YXRpYyBpbnQgX19leGZhdF9mcmVl
X2NsdXN0ZXIoc3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0IGV4ZmF0X2NoYWluICpwX2NoYWlu
CiAJCX0gd2hpbGUgKGNsdSAhPSBFWEZBVF9FT0ZfQ0xVU1RFUik7CiAJfQogCi1kZWNfdXNlZF9j
bHVzOgogCXNiaS0+dXNlZF9jbHVzdGVycyAtPSBudW1fY2x1c3RlcnM7CiAJcmV0dXJuIDA7CiB9
Ci0tIAoyLjI1LjEKCg==
--0000000000002b98ed062c54246a--

