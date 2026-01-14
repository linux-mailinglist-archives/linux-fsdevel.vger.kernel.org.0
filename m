Return-Path: <linux-fsdevel+bounces-73794-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 88822D20AE4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 18:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1C482300FD4B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 17:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02E032ED43;
	Wed, 14 Jan 2026 17:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D96vrZPV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9F92DEA80
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 17:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768413293; cv=none; b=paBYgRnG74Wbzh0IAWZMeGC9m9uiEDHvIGoiNWFNeQ25s4a1VVRbuwHSwHyTnS+bXYQAOLfmMn8NvUNvhOHQW7egL/TUx7gn86uZmmRmJx+M5yyd8O1q4faf4vazHexR29a1kmOmdOndnVu61rCgxd8icgrvV7qdyFcC8OlJrBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768413293; c=relaxed/simple;
	bh=ri6XdCQOo82mlaJDsd+QmjUF07km5DczjkYwbJrj+3s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L4cgRHftrKWcVU4+MBL8pwjygv05xDpuxQ17i3mExvwq27NNj2mA/rEzMjPgzJQaZrSnJVNzhasmHzKhpetznbF4NpURnXWcqP8cbcZbZhvBsIWs7f34HEBACt7ViVQn695g2178F1uiB7nY28wWYyXHsxdEUoZ8sIgffJhShEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D96vrZPV; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b876bf5277dso126037666b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 09:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768413290; x=1769018090; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7JRxCvP4g5SpKNn0OXYTsa9XAVvPE6OA4ZzPHkT0Yco=;
        b=D96vrZPVd1Hu2aUVU0IU+r4oqOYsdqtv6md/7d7E44q7bwze1IwHI1ly0EI7BAtyQZ
         ++AeCxY1VkY7tke0rvuAS5oU+fttP/7/IoEk1PQcYh5Q4w7KItRlGsZdlzH746I3Imfn
         ITygMLQb5EOd1iAi+voF0elp/huUZ0zL1xzoTM7P4wTU7BOSZvVQEbEnBkdgCgaynITO
         IP8y7i2A9TUSZd6vcmIVWM6JVHMk2lAcmXQKdbK2UhR/DOhjgS/s9VBZvuvKUBWDRHnC
         kcXmpRLKbB6uGJ5E8aTrhoCX+PuczveFn6BAUE69KUbuiOeXzYdW/mWtxUjFoNhaUsxP
         lWjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768413290; x=1769018090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7JRxCvP4g5SpKNn0OXYTsa9XAVvPE6OA4ZzPHkT0Yco=;
        b=j7e/lhQyhWp3Y3wgmhqABWg0VjeUdyTsbF4qqMNWM61Mq+xJJ98Zvki6P9raT+8RDU
         rCE2cZW7QDxfW6H2l1ktBHnnpKkVtCKdBz1aQyDtUmLK/beG5LDftWp9kxwKcJG8rjPK
         RT/CVM8PzOGaTgSlvWZ8W5Mr0JkZx9YapnkLnAFp+LASjpKyYORjqxfgx8ALRXlZRVaQ
         z2rIAaR95rVf8IuEVBC35gtD23lBUxctTcMsoazcSG7nLLml5mLjrP3IJQJaU69olLjg
         uM9oqOjABLu1kIFDsA6M1435XCmr0lOsvQW5Lq+Y6Xd6zTZFrGSo9sBXPV4hn0xl+j/0
         3grQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8C2cu8pjKZl8GneEu9K8jebD6Evwzi3wdf34DY0obuh2nnXLFJFY/YO7Pwd9FTnrOCkqbpkaZGSCZbHta@vger.kernel.org
X-Gm-Message-State: AOJu0YxzSMo4f++UjXi0RZKYcK78JkiW+ikZuwMHJS9Chaf9IJUSGaNz
	ILVWrxMMB2OWEotpnm0Vik1G02dovWc/WJnvfeMkdJi/hIPfIyRBhfJSjK8JMpec9gyaks5Dd6z
	l/voRt9LNqJPv3DaEjDwpRpdwbGUDPGQ=
X-Gm-Gg: AY/fxX5gWi3vnMHVuGpKIrZq8Ox4Hpk1RVMf66/e7LTLRrAGLMSJowtCLw9Q6Qp9G9Q
	aeX0s5rX2gfC02cQM0pWSK/tWLbpdzcs9GUqKNqnf50HJnMZzbIF1HpZSEHH9zspD4rEsN7iSLj
	Gj2drJ9rAWx0ND+e+xnR2FWNA+AOZsMWKd/MxESNshCI5PnXoai8p9x1nwidtTK7VP6mjX/ZRzu
	TPE7mMZdn++tIUzj1XnwIRqyi8aqFlEdUfGpJc7EMyteAqJIw9HSmFraTdf4X1x2BG6kGKr4a25
	FwfgFv+usANiJ62OFcvowEJcQkf3T8LLBLfzhOB2
X-Received: by 2002:a17:906:3ca1:b0:b87:6c41:bd6e with SMTP id
 a640c23a62f3a-b8777a0b1a2mr20024966b.5.1768413289489; Wed, 14 Jan 2026
 09:54:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114-tonyk-get_disk_uuid-v1-0-e6a319e25d57@igalia.com> <20260114-tonyk-get_disk_uuid-v1-3-e6a319e25d57@igalia.com>
In-Reply-To: <20260114-tonyk-get_disk_uuid-v1-3-e6a319e25d57@igalia.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 14 Jan 2026 18:54:37 +0100
X-Gm-Features: AZwV_QjJMBsMMFjKP053WyHEfg80dXeyrhI42AdnL-ae8ei5FSGNGR_90taCtJg
Message-ID: <CAOQ4uxjAQu9sQt3qOOVWS5cz5B51Hg0m4RAjsreBkmPhg-2cyw@mail.gmail.com>
Subject: Re: [PATCH 3/3] ovl: Use real disk UUID for origin file handles
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc: Christoph Hellwig <hch@lst.de>, Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
	Tom Talpey <tom@talpey.com>, Carlos Maiolino <cem@kernel.org>, Chris Mason <clm@fb.com>, 
	David Sterba <dsterba@suse.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 5:32=E2=80=AFAM Andr=C3=A9 Almeida <andrealmeid@iga=
lia.com> wrote:
>
> Some filesystem, like btrfs, supports mounting cloned images, but assign
> random UUIDs for them to avoid conflicts. This breaks overlayfs "index"
> check, given that every time the same image is mounted, it get's
> assigned a new UUID.
>
> Fix this assigning the disk UUID for filesystem that implements the
> export operation get_disk_uuid(), so overlayfs check is also against the
> same value.
>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> ---
>  fs/overlayfs/copy_up.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
> index 758611ee4475..8551681fffd3 100644
> --- a/fs/overlayfs/copy_up.c
> +++ b/fs/overlayfs/copy_up.c
> @@ -421,8 +421,26 @@ struct ovl_fh *ovl_encode_real_fh(struct ovl_fs *ofs=
, struct inode *realinode,
>         struct ovl_fh *fh;
>         int fh_type, dwords;
>         int buflen =3D MAX_HANDLE_SZ;
> -       uuid_t *uuid =3D &realinode->i_sb->s_uuid;
> -       int err;
> +       struct super_block *real_sb =3D realinode->i_sb;
> +       uuid_t *uuid =3D &real_sb->s_uuid, real_uuid;
> +       u32 len =3D sizeof(uuid_t);
> +       int err, ret;
> +       u64 offset;
> +
> +       /*
> +        * Some filesystems that support cloned devices may expose random=
 UUIDs
> +        * for userspace, which will cause the upper root origin check to=
 fail
> +        * during a remount. To avoid this, store the real disk UUID.
> +        *
> +        * ENODATA means that the filesystem implements get_disk_uuid(), =
but
> +        * this instance is using the real UUID so we can skip the operat=
ion.
> +        */
> +       if (real_sb->s_export_op && real_sb->s_export_op->get_disk_uuid) =
{
> +               ret =3D real_sb->s_export_op->get_disk_uuid(real_sb, real=
_uuid.b, &len, &offset);
> +
> +               if (!ret || ret !=3D ENODATA)
> +                       uuid =3D &real_uuid;
> +       }
>

Perhaps this is the wrong way to abstract what overlayfs needs from real fs=
.
Maybe better to extend ->encode_fh() to take a flags argument (see similar
suggested patch at [1]) and let overlayfs do something like:

fh_type =3D 0;
if (ovl_origin_uuid(ofs))
        fh_type =3D exportfs_encode_inode_fh(realinode, (void *)fh->fb.uuid=
.b,
                                           &dwords, NULL, EXPORT_FH_WITH_UU=
ID);
if (fh_type <=3D 0)
        fh_type =3D exportfs_encode_inode_fh(realinode, (void *)fh->fb.fid,
                                           &dwords, NULL, 0);

Similarly, in ovl_decode_real_fh() overlayfs won't verify the UUID,
this will be also delegated to the filesystem via exportfs_decode_fh()
whose fh->fb.type already has the EXPORT_FH_WITH_UUID flag.

This is very rough hand waving and details need to be worked out,
but it essentially delegates the encoding  of a "globally unique file handl=
e"
to the filesystem without specifying this or that version of uuid.

Thanks,
Amir.

[1] https://lore.kernel.org/linux-fsdevel/CAOQ4uxj=3DXOFqHBmYY1aBFAnJtSkxzS=
yPu5G3xP1rx=3DZfPfe-kg@mail.gmail.com/

