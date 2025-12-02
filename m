Return-Path: <linux-fsdevel+bounces-70479-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 280F4C9CE3D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 02 Dec 2025 21:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D59C53A605B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Dec 2025 20:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4FA284B25;
	Tue,  2 Dec 2025 20:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JCrNGplQ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="B7ebUeUA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156A1248F64
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Dec 2025 20:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764706912; cv=none; b=LoRYmYRH9vLA8wzXS8y5UGw8fO2VTLeUYuBxse0FQ6CY2IHOuz4HBcynOmrvvqigBWTNsPwGUw5KD6I1VKQ4cZnCAKIewH9sF3I3r2NwFF+8Apx4ZByk0skUeS7YivgW+VP9cuE1dA53z1uZWRJak6653rqpoBs9c+dh09RwyVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764706912; c=relaxed/simple;
	bh=uFFSunVEbnezRufziXi6IUZkUY9I8XBlErU/0HO1Iec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bm1vOGEuwYGwfR9O61mHACeKFbCY/51bI+o0C+MebjbY96mavtAh2QqMCuaur18DUp1lZuCjDRqKrE+OcapQEvVOSsarj5H/dm366jE001IXX4jEdM6AzVlpNwbvRqoqW6PFehFbFj3ihTyXywdTwdEk0B2RE37dz5SCkKnDXrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JCrNGplQ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=B7ebUeUA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764706910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iSFE6n+TpmXW61SIhGGDX5bYL7+8JobCUr/luE2Zuew=;
	b=JCrNGplQkOf04S4gW/0bwL94vapL+ftNI6uOZL0huJoSR2V2L2pWNXqk9P644o1lgPIHAw
	R5+cz3i1vpln1jwNujA5Kp70mk8kQlT7T0pxuyPhhPriTIoUnaeR3WnXVZbDWXXW++Ooih
	bYAEG5mzkdDIw86OjJQb6JHXjAhWIyA=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-S8Wu1FB8NDyb0kZpW5xWow-1; Tue, 02 Dec 2025 15:21:48 -0500
X-MC-Unique: S8Wu1FB8NDyb0kZpW5xWow-1
X-Mimecast-MFC-AGG-ID: S8Wu1FB8NDyb0kZpW5xWow_1764706908
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8804b991a54so175263706d6.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Dec 2025 12:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764706908; x=1765311708; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iSFE6n+TpmXW61SIhGGDX5bYL7+8JobCUr/luE2Zuew=;
        b=B7ebUeUAZ/MNWWfR+fFb2dtASCCf0fTo5QSPqKYNDMueVST91zvAs7lfh4o24vtoij
         pPO1Ws/UWtmYbViC1wRUtJu/mbakj21b4ZLhkmMFWbRKr5gxHcEAWJUze7+MGJqk0POJ
         AZRTQRgBp5QbDNniawJ9mNarp0rhPimMNNnVcfqw0oq/1kTpGgbkVgo8FVFuIHfdHgBE
         Zh327ZaovDK4pthq9SdmP6mhGh9dGXVr9pQkfiDYn1vo+nztlrO49dQQI+MP0VHdfVpS
         ooeZspo+JxEIw852LJrCeAmLcOXpvcFvOhvAAIba+CK6Gys+uRg2KNZW8C/hqeGyidWV
         HGvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764706908; x=1765311708;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iSFE6n+TpmXW61SIhGGDX5bYL7+8JobCUr/luE2Zuew=;
        b=EZB4MfLRDJ4nLSAbP0vsljqODOeEAfrmZ0GLdl9Dqb5cRyJoZmII/cqVKolcthuIky
         ny7Kf9e/bFNIfX/LHR+Dh6DR/tL7H+QWbO6gQkd+XdV/S1N7pym0sz4kV/eP3wJTU0Jq
         XP7t3ofzyRcm0+Jt/noZZGCPOcf7ovQjFqtQl0xFX5HcjwJoxy6xTj+DR4nPTOskezW9
         PQSWcLNp8CLfcU4bplOKnHeivxh7oLKHw0+WtaIMIu336cUZAgrVchnKzaT+kKdHzCNv
         HKH4W7GRwuHqUGi6v+zq308veH94huEoDF0fUmhEIH6IaRO+AdhbN38Z+JbQHLlQW5W1
         vs2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWbGFaPouPkLTiIbugV2jk0AgYUuM4nVHlFq6xMDywZFkgD1j79rxNXVNW+fYh6Kr9JvSO/okyO415sypgY@vger.kernel.org
X-Gm-Message-State: AOJu0YybLBC4g/bpICaoFsgZg6hANQhLvajGuL27Rke7znqBqFVV1JWd
	aRzMSQZFawciRXEV+bwfc+ByZu+XWW/ahK7xRiIVTraJHYSERlg3qbxFpjQfoC68g1zzBmqFPfx
	4piCgXNJ98DvMl7V9J2c0nxBuVh7ES39TmXYiEufUxzon8U6PZ0HQaj2GfYBcnDe1ncucn7obgm
	F7Lxdo7B4iYqIVXOTaNylnbSxoGEc0KeDIYadKC7uf9Q==
X-Gm-Gg: ASbGncsYafddMxKjS13SMM8OTuLADASz4nLxAbbeDc82E5mZ3ex75zFQrRacBrlyUwq
	FzDDOJ/PkHEnIsa7kGj99byIAeoeQu1HHnKB6S2A6NVrHQjVc2+MFuiMyPCuIewuG1TQDBbW+cM
	SRp7XMKqOx2q5DL68SwXaF6gRGGskctZZG/DIsCe8TcpQrpVf/pV5TLOPitD3Lt+oNaA3dRJmrd
	iMLW+L+7pf4du1BmpwN3UrEow==
X-Received: by 2002:a05:622a:178e:b0:4ee:1301:ebac with SMTP id d75a77b69052e-4f014fbf0b1mr13479851cf.57.1764706907833;
        Tue, 02 Dec 2025 12:21:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEoPw2OOq1n6LRBrMWERkmIeSib/LRThIzL8NbW2U5JQWXVWVx189oMo97aOnkn3xUw9sZH613VM3bjVqT8/lY=
X-Received: by 2002:a05:622a:178e:b0:4ee:1301:ebac with SMTP id
 d75a77b69052e-4f014fbf0b1mr13479141cf.57.1764706907255; Tue, 02 Dec 2025
 12:21:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119193745.595930-2-slava@dubeyko.com> <CAOi1vP-bjx9FsRq+PA1NQ8fx36xPTYMp0Li9WENmtLk=gh_Ydw@mail.gmail.com>
 <fe7bd125c74a2df575c6c1f2d83de13afe629a7d.camel@ibm.com> <CAJ4mKGZexNm--cKsT0sc0vmiAyWrA1a6FtmaGJ6WOsg8d_2R3w@mail.gmail.com>
 <370dff22b63bae1296bf4a4c32a563ab3b4a1f34.camel@ibm.com> <CAPgWtC58SL1=csiPa3fG7qR0sQCaUNaNDTwT1RdFTHD2BLFTZw@mail.gmail.com>
 <183d8d78950c5f23685c091d3da30d8edca531df.camel@ibm.com> <CAPgWtC7AvW994O38x4gA7LW9gX+hd1htzjnjJ8xn-tJgP2a8WA@mail.gmail.com>
 <9534e58061c7832826bbd3500b9da9479e8a8244.camel@ibm.com> <CAPgWtC5Zk7sKnP_-jH3Oyb8LFajt_sXEVBgguFsurifQ8hzDBA@mail.gmail.com>
 <6b405f0ea9e8cb38238d98f57eba9047ffb069c7.camel@ibm.com> <CAOi1vP83qU-J4b1HyQ4awYN_F=xQAaP8dGYFfXxnxoryBC1c7w@mail.gmail.com>
In-Reply-To: <CAOi1vP83qU-J4b1HyQ4awYN_F=xQAaP8dGYFfXxnxoryBC1c7w@mail.gmail.com>
From: Patrick Donnelly <pdonnell@redhat.com>
Date: Tue, 2 Dec 2025 15:21:20 -0500
X-Gm-Features: AWmQ_blhXtJ3e--0rgwIZUVFMYte1XlR8f4gLB8vjEVsMziQG5Uo-0YKElIhOiw
Message-ID: <CA+2bHPYLsoFCPnhgOsd7VbSAmrbzXPJDiGW1WZWpPZvdduA6xQ@mail.gmail.com>
Subject: Re: [PATCH] ceph: fix kernel crash in ceph_open()
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>, 
	Kotresh Hiremath Ravishankar <khiremat@redhat.com>, Viacheslav Dubeyko <vdubeyko@redhat.com>, 
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "slava@dubeyko.com" <slava@dubeyko.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Gregory Farnum <gfarnum@redhat.com>, 
	Alex Markuze <amarkuze@redhat.com>, Pavan Rallabhandi <Pavan.Rallabhandi@ibm.com>, 
	Venky Shankar <vshankar@redhat.com>
Content-Type: multipart/mixed; boundary="000000000000578ef50644fdd8c2"

--000000000000578ef50644fdd8c2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I started work on a patch and it is largely in agreement with what
Ilya suggested below.

On Tue, Dec 2, 2025 at 6:30=E2=80=AFAM Ilya Dryomov <idryomov@gmail.com> wr=
ote:
> Hi Slava,
>
> I think the right solution would be a patch that establishes
> consistency with the userspace client.  What does ceph-fuse do when
> --client_fs option isn't passed?  It's the exact equivalent of
> mds_namespace mount option (--client_mds_namespace is what it used to
> be named), so the kernel client just needs to be made to do exactly the
> same.
>
> After taking a deeper look I doubt that using the default fs_name for
> the comparison would be sufficient and not prone to edge cases.  First,
> even putting the NULL dereference aside, both the existing check by
> Kotresh
>
>     if (auth->match.fs_name && strcmp(auth->match.fs_name, fs_name))
>         /* mismatch */
>
> and your proposed check
>
>     if (!fs_name1 || !fs_name2)
>         /* match */
>
>     if (strcmp(fs_name1, fs_name2))
>         /* mismatch */
>
> aren't equivalent to
>
>   bool match_fs(std::string_view target_fs) const {
>     return fs_name =3D=3D target_fs || fs_name.empty() || fs_name =3D=3D =
"*";
>   }
>
> in src/mds/MDSAuthCaps.h -- "*" isn't handled at all.
>
> Second, I'm not following a reason to only "validate" fs_name against
> mds_namespace option in ceph_mdsmap_decode().  Why not hold onto it and
> actually use it in ceph_mds_auth_match() for the comparison as done in
> src/client/Client.cc?
>
> int Client::mds_check_access(std::string& path, const UserPerm& perms, in=
t mask)
> {
>   ...
>   std::string_view fs_name =3D mdsmap->get_fs_name();   <---------
>   for (auto& s: cap_auths) {
>     ...
>     if (s.match.match(fs_name, path, perms.uid(), perms.gid(), &gid_list)=
) {
>       /* match */
>
> AFAIU the default fs_name would come into the picture only in case of
> a super ancient cluster with prior to mdsmap v8 encoding.
>
> I haven't really looked at this code before, so it's possible that
> there are other things that are missing/inconsistent here.  I'd ask
> that the final patch is formally reviewed by Venky and Patrick as
> they were the approvers on https://github.com/ceph/ceph/pull/64550
> in userspace.

We should match the ceph-fuse client behavior.

Attached is the patch (I've not built) which roughly gets us there.
The missing bit will be the "*" glob matching.

In summary, we should definitely start decoding `fs_name` from the
MDSMap and do strict authorizations checks against it. Note that the
`--mds_namespace` should only be used for selecting the file system to
mount and nothing else. It's possible no mds_namespace is specified
but the kernel will mount the only file system that exists which may
have name "foo".


--
Patrick Donnelly, Ph.D.
He / Him / His
Red Hat Partner Engineer
IBM, Inc.
GPG: 19F28A586F808C2402351B93C3301A3E258DD79D

--000000000000578ef50644fdd8c2
Content-Type: application/x-patch; name="fs_name.patch"
Content-Disposition: attachment; filename="fs_name.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mip0u8fx0>
X-Attachment-Id: f_mip0u8fx0

ZGlmZiAtLWdpdCBhL2ZzL2NlcGgvbWRzX2NsaWVudC5jIGIvZnMvY2VwaC9tZHNfY2xpZW50LmMK
aW5kZXggMTc0MDA0N2FlZjBmLi42ZTJmOTQ1NTdmYzQgMTAwNjQ0Ci0tLSBhL2ZzL2NlcGgvbWRz
X2NsaWVudC5jCisrKyBiL2ZzL2NlcGgvbWRzX2NsaWVudC5jCkBAIC01NjU1LDcgKzU2NTUsNyBA
QCBzdGF0aWMgaW50IGNlcGhfbWRzX2F1dGhfbWF0Y2goc3RydWN0IGNlcGhfbWRzX2NsaWVudCAq
bWRzYywKIAl1MzIgY2FsbGVyX3VpZCA9IGZyb21fa3VpZCgmaW5pdF91c2VyX25zLCBjcmVkLT5m
c3VpZCk7CiAJdTMyIGNhbGxlcl9naWQgPSBmcm9tX2tnaWQoJmluaXRfdXNlcl9ucywgY3JlZC0+
ZnNnaWQpOwogCXN0cnVjdCBjZXBoX2NsaWVudCAqY2wgPSBtZHNjLT5mc2MtPmNsaWVudDsKLQlj
b25zdCBjaGFyICpmc19uYW1lID0gbWRzYy0+ZnNjLT5tb3VudF9vcHRpb25zLT5tZHNfbmFtZXNw
YWNlOworCWNvbnN0IGNoYXIgKmZzX25hbWUgPSBtZHNjLT5tZHNtYXAtPm1fZnNfbmFtZTsKIAlj
b25zdCBjaGFyICpzcGF0aCA9IG1kc2MtPmZzYy0+bW91bnRfb3B0aW9ucy0+c2VydmVyX3BhdGg7
CiAJYm9vbCBnaWRfbWF0Y2hlZCA9IGZhbHNlOwogCXUzMiBnaWQsIHRsZW4sIGxlbjsKZGlmZiAt
LWdpdCBhL2ZzL2NlcGgvbWRzbWFwLmMgYi9mcy9jZXBoL21kc21hcC5jCmluZGV4IDJjN2IxNTFh
N2M5NS4uZjE4NTYzM2E2YWVhIDEwMDY0NAotLS0gYS9mcy9jZXBoL21kc21hcC5jCisrKyBiL2Zz
L2NlcGgvbWRzbWFwLmMKQEAgLTM1NiwxOSArMzU2LDIxIEBAIHN0cnVjdCBjZXBoX21kc21hcCAq
Y2VwaF9tZHNtYXBfZGVjb2RlKHN0cnVjdCBjZXBoX21kc19jbGllbnQgKm1kc2MsIHZvaWQgKipw
LAogCQl1MzIgZnNuYW1lX2xlbjsKIAkJLyogZW5hYmxlZCAqLwogCQljZXBoX2RlY29kZV84X3Nh
ZmUocCwgZW5kLCBtLT5tX2VuYWJsZWQsIGJhZF9leHQpOworCisJCW0tPm1fZnNfbmFtZSA9IGNl
cGhfZXh0cmFjdF9lbmNvZGVkX3N0cmluZyhwLCBlbmQsIGZzbmFtZV9sZW4sIEdGUF9OT0ZTKQog
CQkvKiBmc19uYW1lICovCiAJCWNlcGhfZGVjb2RlXzMyX3NhZmUocCwgZW5kLCBmc25hbWVfbGVu
LCBiYWRfZXh0KTsKIAogCQkvKiB2YWxpZGF0ZSBmc25hbWUgYWdhaW5zdCBtZHNfbmFtZXNwYWNl
ICovCi0JCWlmICghbmFtZXNwYWNlX2VxdWFscyhtZHNjLT5mc2MtPm1vdW50X29wdGlvbnMsICpw
LAotCQkJCSAgICAgIGZzbmFtZV9sZW4pKSB7CisJCWlmICghbmFtZXNwYWNlX2VxdWFscyhtZHNj
LT5mc2MtPm1vdW50X29wdGlvbnMsIG0tPm1fZnNfbmFtZSwgZnNuYW1lX2xlbikpIHsKIAkJCXBy
X3dhcm5fY2xpZW50KGNsLCAiZnNuYW1lICUqcEUgZG9lc24ndCBtYXRjaCBtZHNfbmFtZXNwYWNl
ICVzXG4iLAotCQkJCSAgICAgICAoaW50KWZzbmFtZV9sZW4sIChjaGFyICopKnAsCisJCQkJICAg
ICAgIChpbnQpZnNuYW1lX2xlbiwgbS0+bV9mc19uYW1lLAogCQkJCSAgICAgICBtZHNjLT5mc2Mt
Pm1vdW50X29wdGlvbnMtPm1kc19uYW1lc3BhY2UpOwogCQkJZ290byBiYWQ7CiAJCX0KLQkJLyog
c2tpcCBmc25hbWUgYWZ0ZXIgdmFsaWRhdGlvbiAqLwotCQljZXBoX2RlY29kZV9za2lwX24ocCwg
ZW5kLCBmc25hbWVfbGVuLCBiYWQpOworCX0gZWxzZSB7CisJCW0tPm1fZW5hYmxlZCA9IGZhbHNl
OworCQltLT5tX2ZzX25hbWUgPSBrc3RyZHVwKCJjZXBoZnMiLCBHRlBfTk9GUyk7IC8qIG5hbWUg
Zm9yICJvbGQiIENlcGhGUyBmaWxlIHN5c3RlbXMsIHNlZSBjZXBoLmdpdCBlMmIxNTFkMDA5NjQw
MTE0YjI1NjVjOTAxZDZmNDFmNmNkNWVjNjUyICovCiAJfQogCS8qIGRhbWFnZWQgKi8KIAlpZiAo
bWRzbWFwX2V2ID49IDkpIHsKQEAgLTQzMCw2ICs0MzIsNyBAQCB2b2lkIGNlcGhfbWRzbWFwX2Rl
c3Ryb3koc3RydWN0IGNlcGhfbWRzbWFwICptKQogCQlrZnJlZShtLT5tX2luZm8pOwogCX0KIAlr
ZnJlZShtLT5tX2RhdGFfcGdfcG9vbHMpOworCWtmcmVlKG0tPm1fZnNfbmFtZSk7CiAJa2ZyZWUo
bSk7CiB9CiAKZGlmZiAtLWdpdCBhL2ZzL2NlcGgvbWRzbWFwLmggYi9mcy9jZXBoL21kc21hcC5o
CmluZGV4IDFmMjE3MWRkMDFiZi4uYzEzNzEyMWIwMzMxIDEwMDY0NAotLS0gYS9mcy9jZXBoL21k
c21hcC5oCisrKyBiL2ZzL2NlcGgvbWRzbWFwLmgKQEAgLTQ1LDYgKzQ1LDcgQEAgc3RydWN0IGNl
cGhfbWRzbWFwIHsKIAlib29sIG1fZW5hYmxlZDsKIAlib29sIG1fZGFtYWdlZDsKIAlpbnQgbV9u
dW1fbGFnZ3k7CisJY2hhciogbV9mc19uYW1lOwogfTsKIAogc3RhdGljIGlubGluZSBzdHJ1Y3Qg
Y2VwaF9lbnRpdHlfYWRkciAqCg==
--000000000000578ef50644fdd8c2--


