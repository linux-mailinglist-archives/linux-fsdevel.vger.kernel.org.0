Return-Path: <linux-fsdevel+bounces-30204-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B797987B08
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 00:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5ED7FB2233F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 22:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2881898EE;
	Thu, 26 Sep 2024 22:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQJn5mfb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB4218953E
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Sep 2024 22:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727388629; cv=none; b=tYu33qcEWbtiFNSNyfM5SFEewuu4SgFQXv01vRz2dMfE5kHlNzMXXsKx545PlFMb2xoUGxNK2RjW9LpLJO33vBd8M0rhKTxWNPgDiQ8sUYm/hQUmFCkF1zF5zZf1P410afSZRIGSm//wj0FuM17iFAIiVPMyRLPYgJoaJsuEu1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727388629; c=relaxed/simple;
	bh=G+L6BGRI1dQMplCLGhjNNKl68X658qh33Dvj/U6qwXU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hRWY7rUrX455uatNCV6NKTMvotIke4yC1gY4T0EIqKbxmAdWb//cLExWEn/6iwXpgKvhPJehGUyX/8yc/w3d6nN1txgekJ/23p6jUJ7n3LqEdR6kpzdVOvDZdevIpL155IFpO8p052t69E23ieuDfZjtSdvJAmZMEu7puYCp1G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KQJn5mfb; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7a99de9beb2so107116185a.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Sep 2024 15:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727388626; x=1727993426; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XzolFJ9r7P6dC1Xh/Y6FYKRpWyNfvBP43rsrIRfwlv8=;
        b=KQJn5mfba7Eo4y8JHDtDoyww8tqPUz7342TF0Vk7pImOUBSjM8+DY6fOTISbUmU8Co
         ue5FTdW7OYhtOr3UQishDn6N/ca9iN2922pc8gd+drUcLmcM3Zt6ngOZbnt6haseTngo
         7IzlvXO5iHLRYhxlUmANsAObtzE+oO5zGe1mc24OT6R12FNjzt4OCSs8dKIcJL6w4DMo
         yWuShHiAduWu1szKhNif80uiCQ55b2NanK9v1IsM930rtNA7ItZdM4Geyo5b4KdYHRbk
         gtSoFlyJAf8d7XxS4CBxlscmSS49j6b3LBL2108z0Q/XsFbjjQ6JmC/CimGEmgKmPUpX
         M/pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727388626; x=1727993426;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XzolFJ9r7P6dC1Xh/Y6FYKRpWyNfvBP43rsrIRfwlv8=;
        b=Q+OuNC4p6aSlrSPrywaJDi0Czt+8m+ByYIIsO9WaitVCd4xZ1scCIxdiC+yuaVxCCV
         CyOdzrK8HJFeEDTH7cQV6Qm+XyTrzzXsB2dUFLivTZcCm8Lv5eyXwQZR9wFOhdh5Mw2n
         1NXvEyYED64gJKFH8XNXxu6NFIo6mlV5JnHG40MVyI4IilQVD1ijIIXGeQE6v04mpaiO
         GOnILaOb72e9rY4b4bz+V3P/LZcBVmzdfV1Cy3g26yzZ3+LLotc4dEUz8rw1qwMEUkVa
         XCsc5stRpeLCZJOSYwf0KPUDf19/uwhmTYqhHlEjqEpJp02BbpOR+3pLELhSRwdeC2fx
         KPWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrZMQxVraYaDcsVdDQufbLVsBSam8VEF+KMwrv62812e1kwwLG36PpyxuZJTsX8/uqqkLHjUdFpCcdRVL4@vger.kernel.org
X-Gm-Message-State: AOJu0YxBei8qBZicFFHIJvXXitfMNLaNMDStFEUCOnsZuMvSiLlLhOII
	BS0Js7AQJUOJs4R5yQSTTFSd8UbKQm5xP6/+5bex07+1jjxsjMp0xUe4XbbnxqLssdoOw9+YCjo
	yL827n4tIm6jRAL9ff5jeguuNmJk=
X-Google-Smtp-Source: AGHT+IFz7MzXUpx/7skxhd/YFqB/RceGdY1NOSEf+hmf5J4yYDT2reFYBVxZMcnoTz3IOAXM4uHMf6zohfQgaqLHQO0=
X-Received: by 2002:a05:620a:17ab:b0:7a9:c13d:6e5c with SMTP id
 af79cd13be357-7ae37852751mr128385485a.29.1727388626322; Thu, 26 Sep 2024
 15:10:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <SI2P153MB07182F3424619EDDD1F393EED46D2@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
 <CAOQ4uxiuPn4g1EBAq70XU-_5tYOXh4HqO5WF6O2YsfF9kM=qPw@mail.gmail.com>
 <SI2P153MB07187CEE4DFF8CDD925D6812D4682@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
 <CAOQ4uxjd2pf-KHiXdHWDZ10um=_Joy9y5_1VC34gm6Yqb-JYog@mail.gmail.com>
 <SI2P153MB0718D1D7D2F39F48E6D870C1D4682@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
 <SI2P153MB07187B0BE417F6662A991584D4682@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
 <20240925081146.5gpfxo5mfmlcg4dr@quack3> <20240925081808.lzu6ukr6pr2553tf@quack3>
 <CAOQ4uxji2ENLXB2CeUmt72YhKv_wV8=L=JhnfYTh0RTunyTQXw@mail.gmail.com>
 <20240925113834.eywqa4zslz6b6dag@quack3> <CAOQ4uxgEcQ5U=FOniFRnV1k1EYpqEjawt52377VgFh7CY2pP8A@mail.gmail.com>
 <JH0P153MB0999C71E821090B2C13227E5D4692@JH0P153MB0999.APCP153.PROD.OUTLOOK.COM>
 <CAOQ4uxirX3XUr4UOusAzAWhmhaAdNbVAfEx60CFWSa8Wn9y5ZQ@mail.gmail.com>
 <JH0P153MB0999464D8F8D0DE2BC38EE62D4692@JH0P153MB0999.APCP153.PROD.OUTLOOK.COM>
 <CAOQ4uxjfO0BJUsnB-QqwqsjQ6jaGuYuAizOB6N2kNgJXvf7eTg@mail.gmail.com>
 <JH0P153MB099940642723553BA921C520D46A2@JH0P153MB0999.APCP153.PROD.OUTLOOK.COM>
 <CAOQ4uxjyihkjfZTF3qVX0varsj5HyjqRRGvjBHTC5s258_WpiQ@mail.gmail.com> <CAOQ4uxivUh4hKoB_V3H7D75wTX1ijX4bV4rYcgMyoEuZMD+-Eg@mail.gmail.com>
In-Reply-To: <CAOQ4uxivUh4hKoB_V3H7D75wTX1ijX4bV4rYcgMyoEuZMD+-Eg@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 27 Sep 2024 00:10:14 +0200
Message-ID: <CAOQ4uxgRnzB0E2ESeqgZBHW++zyRj8-VmvB38Vxm5OXgr=EM9g@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: Git clone fails in p9 file system marked with FANOTIFY
To: Krishna Vivek Vitta <kvitta@microsoft.com>
Cc: Jan Kara <jack@suse.cz>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Eric Van Hensbergen <ericvh@kernel.org>, 
	Latchesar Ionkov <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>, 
	"v9fs@lists.linux.dev" <v9fs@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 10:28=E2=80=AFPM Amir Goldstein <amir73il@gmail.com=
> wrote:
>
> > > What would be the next steps for this investigation ?
> > >
> >
> > I need to find some time and to debug the reason for 9p open failure
> > so we can make sure the problem is in 9p code and report more details
> > of the bug to 9p maintainers, but since a simple reproducer exists,
> > they can also try to reproduce the issue right now.
>
> FWIW, the attached reproducer mimics git clone rename_over pattern closer=
.
> It reproduces fanotify_read() errors sometimes, not always,
> with either CLOSE_WRITE or OPEN_PERM | CLOSE_WRITE.
> maybe CLOSE_WRITE alone has better odds - I'm not sure.
>

scratch that.
I think the renames were just a destruction
git clone events do not always fail on a close+rename pattern,
they always fail on the close+unlink that follows the renames:

1776  openat(AT_FDCWD, "/vtmp/filebench/.git/tjEzMUw",
O_RDWR|O_CREAT|O_EXCL, 0600) =3D 3
1776  close(3)                          =3D 0
1776  unlink("/vtmp/filebench/.git/tjEzMUw") =3D 0
1776  symlink("testing", "/vtmp/filebench/.git/tjEzMUw") =3D 0
1776  lstat("/vtmp/filebench/.git/tjEzMUw", {st_mode=3DS_IFLNK|0777,
st_size=3D7, ...}) =3D 0
1776  unlink("/vtmp/filebench/.git/tjEzMUw") =3D 0

I know because I added this print:

--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -275,6 +275,7 @@ static int create_fd(struct fsnotify_group *group,
const struct path *path,
                 */
                put_unused_fd(client_fd);
                client_fd =3D PTR_ERR(new_file);
+               pr_warn("%s(%pd2): ret=3D%d\n", __func__, path->dentry,
client_fd);
        } else {

We should consider adding it as is or maybe ratelimited.

The trivial reproducer below fails fanotify_read() always with one try.

Thanks,
Amir.

int main() {
    const char *filename =3D "config.lock";
    int fd;

    // Create a new file
    fd =3D open(filename, O_WRONLY | O_CREAT | O_TRUNC, 0644);
    if (fd =3D=3D -1) {
        perror("Failed to create file");
        return EXIT_FAILURE;
    }
    close(fd);

    // Remove the file
    if (unlink(filename) !=3D 0) {
        perror("Failed to unlink file");
        return EXIT_FAILURE;
    }

    return EXIT_SUCCESS;
}

