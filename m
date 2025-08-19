Return-Path: <linux-fsdevel+bounces-58282-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C100CB2BE4A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 12:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB16316368F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 09:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFE131B12D;
	Tue, 19 Aug 2025 09:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="QCbr7fqv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9C0311C14;
	Tue, 19 Aug 2025 09:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755597576; cv=none; b=RyY6i9CmMp6yIWaIhNfxg4dSAeP62lKkerzfAhV1dSFjDkdDARziwaSMqD4CY20c+zn4kK5eeNQ2cJ6PjsaK1gI9QFuCPH8bNxKEQ9OBXZxoDhWHrhb70ynsuc2xZCqSbt2H7xKxCJlj7UvbE9fC3T9R/sy9dYMkI2+FroLyJgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755597576; c=relaxed/simple;
	bh=0SjpREjI2Q2MvQZ5ydpsq9i5rbV3TEayh25joekAxCA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iadV2jBxg2Q/zxRZT7GFQO0sz8Q0FuPma7vHhEd1IyuYiAujk1GnTzDnpy8BSUsHbPTmAJxMm3ScXsLevdAgsSTWDoE9BPK2xrPLHyycoVftdBq8pGUEFZ50vbpar9LA0no5QrSLtbhGFR6r/Wv8vBGouJYHD18sB3Em1glCins=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=QCbr7fqv; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=pycWx3rjPc7De/ejdEMCmkQrKPJf3+jrXK0iLEWbk5Y=; b=QCbr7fqvzAUs3krt69zwNama4b
	4nLQ0QIDtrDUDUbUSejfj/XHJgfVcIMn2S8WjbPUnPMoGSYKQkE3Ir9z1fNEds3vc/4RT8RcjbZfG
	cY/7CkAYBjkDXcd747MPEkE8GtFv4UGaNOFC5ZVamsM7dhHljcFilVB7NWEBB9bfK7UPW/covzlt/
	dBbwCiPABnB+kAilUBl5MMsGUOpIniX8jp6YqwR+y4Utd6+6myV5bZcP9Grvw2Bv7rTeLyN0TLyAi
	AMWzo7GrxUhTYRIiU/jV+uomnnsR+3hDmMsD/sqwCS/1cqvMujCRVhWISYQoqA6LI1elzTix8ytcI
	Oi/tT9Ig==;
Received: from bl23-10-177.dsl.telepac.pt ([144.64.10.177] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uoJ7g-00GF2k-FM; Tue, 19 Aug 2025 11:59:20 +0200
From: Luis Henriques <luis@igalia.com>
To: Chunsheng Luo <luochunsheng@ustc.edu>
Cc: bernd@bsbernd.com,  david@fromorbit.com,  kernel-dev@igalia.com,
  laura.promberger@cern.ch,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org,  mharvey@jumptrading.com,
  miklos@szeredi.hu
Subject: Re: [PATCH v4] fuse: new work queue to periodically invalidate
 expired dentries
In-Reply-To: <20250819035208.540-1-luochunsheng@ustc.edu> (Chunsheng Luo's
	message of "Tue, 19 Aug 2025 11:52:08 +0800")
References: <20250707153413.19393-1-luis@igalia.com>
	<20250819035208.540-1-luochunsheng@ustc.edu>
Date: Tue, 19 Aug 2025 10:59:14 +0100
Message-ID: <87ldnfmy31.fsf@wotan.olymp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19 2025, Chunsheng Luo wrote:

> On Mon,  7 Jul 2025 16:34:13 Luis Henriques wrote:
>
>>+static void fuse_dentry_tree_add_node(struct dentry *dentry)
>>+{
>>+	struct fuse_conn *fc =3D get_fuse_conn_super(dentry->d_sb);
>>+	struct fuse_dentry *fd =3D dentry->d_fsdata;
>>+	struct fuse_dentry *cur;
>>+	struct rb_node **p, *parent =3D NULL;
>>+	bool start_work =3D false;
>>+
>>+	if (!fc->inval_wq)
>>+		return;
>
> First check.
>
>>+
>>+	spin_lock(&fc->dentry_tree_lock);
>>+
>>+	if (!fc->inval_wq) {
>>+		spin_unlock(&fc->dentry_tree_lock);
>>+		return;
>>+	}
>
> Check again.
>
> I don't think the if (!fc->inval_wq) check needs to be re-evaluated
> while holding the lock. The reason is that the inval_wq variable=20
> doesn't appear to require lock protection. It only gets assigned=20
> during fuse_conn_init and fuse_conn_destroy. Furthermore,=20
> in fuse_conn_destroy we set inval_wq to zero without holding a lock,=20
> and then synchronously cancel any pending work items.=20
>
> Therefore, performing this check twice with if (!fc->inval_wq)=20
> seems unnecessary.

Thank you for your feedback, Chunsheng.  Having two checks here was just a
small optimisation, the second one is the _real_ one.  So yeah, I guess
it's fine to drop the first one.

Cheers,
--=20
Lu=C3=ADs

> Also, in the subject, it would be more appropriate to change
> "work queue" to "workqueue".
>
> Thanks
> Chunsheng Luo
>
>>+
>>+	start_work =3D RB_EMPTY_ROOT(&fc->dentry_tree);
>>+	__fuse_dentry_tree_del_node(fc, fd);
>>+
>>+	p =3D &fc->dentry_tree.rb_node;
>>+	while (*p) {
>>+		parent =3D *p;
>>+		cur =3D rb_entry(*p, struct fuse_dentry, node);
>>+		if (fd->time > cur->time)
>>+			p =3D &(*p)->rb_left;
>>+		else
>>+			p =3D &(*p)->rb_right;
>>+	}
>>+	rb_link_node(&fd->node, parent, p);
>>+	rb_insert_color(&fd->node, &fc->dentry_tree);
>>+	spin_unlock(&fc->dentry_tree_lock);
>>+
>>+	if (start_work)
>>+		schedule_delayed_work(&fc->dentry_tree_work,
>>+				      secs_to_jiffies(fc->inval_wq));
>>+}

