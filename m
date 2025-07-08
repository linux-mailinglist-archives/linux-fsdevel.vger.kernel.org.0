Return-Path: <linux-fsdevel+bounces-54285-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 134F6AFD522
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 19:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF09A1AA3E5C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 17:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F099C2E6D03;
	Tue,  8 Jul 2025 17:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QRZ2RsTc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E892E6D12
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Jul 2025 17:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751995121; cv=none; b=A3pDp/OSO3bqnPBbO2gOiTU2xkz7+QjTVhmKhR7nOqgLQyWCp0elxwK8tbdF8vJJUlN2jdU4boiEnMPF1IJweTevXG0e+qurUCHdxCKsFiEQ9N/4o5nG49EDQaGNr4gfe+PEyLEcCAUI4RuL7udi0+KWurJ0iS5eesTd/f2OQgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751995121; c=relaxed/simple;
	bh=Vr/EWWEkyyInoAlkIk7ZoimQuzxfPlJt1CXpCF6W9Aw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fZGI+5vvPnkV0rZ39aowROaiNJJJ8qYbDcl16ljqJ9+hKpn91D8fM/BLRMjldr3Zw2IfrR9LYHoyKGMVdbnBdLJ6tw0DsScpdSL0egpLE1Q8eaOLLHTB5hS0o1Shj3tJK/Y9/Bjx1kUPB6VM+UUwzZuI5ZdejJjvdrTSGMzjRqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QRZ2RsTc; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e740a09eae0so4673016276.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Jul 2025 10:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751995118; x=1752599918; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Qc9rBPSIEJF0OIvz6/34bSnoOIIBxdIHXjKLVLFRiwI=;
        b=QRZ2RsTc+TnQPp4q6prZeck1+WJ7iP7A9GHhQ9yXxIhWjyrYz4rUlCZiKpE18tdSAs
         MyReCtogCV1ZcHgL2L6UdRzUPdnDpeRMHHZamOCA7TZXTSV0cHDPedNiKux/ZU/ynXQD
         iamowYHLCiiq7DGKXSveLVQ866uM/E9bbnGcJiQIesuffxOG9okzyOGcmwJGJ3jQRs2u
         5M25ne2MhiSv/R7OqzSawm5HrQYsImKwmFZjcAiF26xPqKmCBJMyDWMJ/qJgrkQjQ6wC
         nAuLhP8eBA1dY4DYDjMoDfHBZGj2Dem+KDjDGCWX3BcZUqwnY5mWURKODfZdj27EAZLr
         J3Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751995118; x=1752599918;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qc9rBPSIEJF0OIvz6/34bSnoOIIBxdIHXjKLVLFRiwI=;
        b=s0bow8GyC2/gk7gpCD0Ibg0s8N15+S5Rj1ZLR/nxrGbdfNKY/H7KjgeqCnfT3qp8NX
         wcog9WdPp0QAGcYuNm2K3Jk9GqnoykFbzJS4acA0IvXteZYOVS5KcDgo24QhXYqxyKo8
         /cAicN7QkpiEIMkgdkc4WnMk1yVMawePss3r4Kno3UdmA++xpocNOJ/8/PLLdYrNpOoI
         B0an4sEb3W6QHjp36C/in2fI/kGhTN7XinPzvBDAU7GLWDRsykprUiwv8yJljinKUex+
         R0EHfADEGkyU9O7BOa86B0PWjv/CtTxzl/EoJT09ZbJS+VkJEoJu7NPMi8gIITD/rcQW
         ds/Q==
X-Gm-Message-State: AOJu0YxYEyN+3E9y54n2Wnb9NwZtSjMC+ZnW0GrFuoASMuGv0V+MNH/I
	4RMmL5x5H+Seu5Eup3EU0TtKDCu7CXe7vTt0+JzxIDRyle+pMZq9hVkcXgp9aISFVybVP6WWtjg
	G0e5YIO5A68OFpqnQWzu0XVJrqnRPRlTN22Zu
X-Gm-Gg: ASbGncucb83mHlAaGIztuILB7EBZpLXRSAw0MzxY2XqzuBh98MoYzdbz61wdK+aMnS6
	XkedUMJvR4xQLK5KX57GLnrLH7CQ+/hWAR8Y2rf1CSKNRKb9JfUT6dCFnGCHfVDiF7fpJFFXhkm
	dfo0P5XCOjwGBseAZxxZlW2V4vpB7O2hJgi9U4eUA/LnDf
X-Google-Smtp-Source: AGHT+IGF9BLh9pm/p3DwezMbKpO8QqTVdky/4dSDa3ochgG1g7x3q5YgOqKNJFF7Ru6Ppr4cq2Y5U1d9aFI2LDgrkk0=
X-Received: by 2002:a05:690c:6d10:b0:70d:f237:6a53 with SMTP id
 00721157ae682-717adfc2edcmr9914877b3.9.1751995118152; Tue, 08 Jul 2025
 10:18:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702212917.GK3406663@ZenIV> <b3ff59d4-c6c3-4b48-97e3-d32e98c12de7@broadcom.com>
 <CAAmqgVMmgW4PWy289P4a8N0FSZA+cHybNkKbLzFx_qBQtu8ZHA@mail.gmail.com>
 <CABPRKS8+SabBbobxxtY8ZCK7ix_VLVE1do7SpcRQhO3ctTY19Q@mail.gmail.com>
 <20250704042504.GQ1880847@ZenIV> <CABPRKS89iGUC5nih40yc9uRMkkfjZUafAN59WQBzpGC3vK_MkQ@mail.gmail.com>
 <20250704201027.GS1880847@ZenIV> <CABPRKS_hSYbJHid=GJo4r9RGUjNWMYA04CwM+M=yPHY5kQXUTw@mail.gmail.com>
 <20250708025734.GT1880847@ZenIV>
In-Reply-To: <20250708025734.GT1880847@ZenIV>
From: Justin Tee <justintee8345@gmail.com>
Date: Tue, 8 Jul 2025 10:17:37 -0700
X-Gm-Features: Ac12FXw55PC55WpfpC74K1iMp4QoKxCMM1P6JviVbowTmya1zFJ-c3j7ZrG55II
Message-ID: <CABPRKS_ARbZbfhG4f1hxWx9j8ZSATd9bkZJu6kq7_dSDF-pHig@mail.gmail.com>
Subject: Re: [PATCH 11/11] lpfc: don't use file->f_path.dentry for comparisons
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, James Smart <james.smart@broadcom.com>, 
	Justin Tee <justin.tee@broadcom.com>, Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

> [PATCH v2] lpfc: don't use file->f_path.dentry for comparisons
>
> If you want a home-grown switch, at least use enum for selector...
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
> diff --git a/drivers/scsi/lpfc/lpfc_debugfs.c b/drivers/scsi/lpfc/lpfc_debugfs.c
> index 3fd1aa5cc78c..42d138ec11b4 100644
> --- a/drivers/scsi/lpfc/lpfc_debugfs.c
> +++ b/drivers/scsi/lpfc/lpfc_debugfs.c
> @@ -2375,32 +2375,32 @@ static ssize_t
>  lpfc_debugfs_dif_err_read(struct file *file, char __user *buf,
>         size_t nbytes, loff_t *ppos)
>  {
> -       struct dentry *dent = file->f_path.dentry;
>         struct lpfc_hba *phba = file->private_data;
> +       int kind = debugfs_get_aux_num(file);
>         char cbuf[32];
>         uint64_t tmp = 0;
>         int cnt = 0;
>
> -       if (dent == phba->debug_writeGuard)
> +       if (kind == writeGuard)
>                 cnt = scnprintf(cbuf, 32, "%u\n", phba->lpfc_injerr_wgrd_cnt);
> -       else if (dent == phba->debug_writeApp)
> +       else if (kind == writeApp)
>                 cnt = scnprintf(cbuf, 32, "%u\n", phba->lpfc_injerr_wapp_cnt);
> -       else if (dent == phba->debug_writeRef)
> +       else if (kind == writeRef)
>                 cnt = scnprintf(cbuf, 32, "%u\n", phba->lpfc_injerr_wref_cnt);
> -       else if (dent == phba->debug_readGuard)
> +       else if (kind == readGuard)
>                 cnt = scnprintf(cbuf, 32, "%u\n", phba->lpfc_injerr_rgrd_cnt);
> -       else if (dent == phba->debug_readApp)
> +       else if (kind == readApp)
>                 cnt = scnprintf(cbuf, 32, "%u\n", phba->lpfc_injerr_rapp_cnt);
> -       else if (dent == phba->debug_readRef)
> +       else if (kind == readRef)
>                 cnt = scnprintf(cbuf, 32, "%u\n", phba->lpfc_injerr_rref_cnt);
> -       else if (dent == phba->debug_InjErrNPortID)
> +       else if (kind == InjErrNPortID)
>                 cnt = scnprintf(cbuf, 32, "0x%06x\n",
>                                 phba->lpfc_injerr_nportid);
> -       else if (dent == phba->debug_InjErrWWPN) {
> +       else if (kind == InjErrWWPN) {
>                 memcpy(&tmp, &phba->lpfc_injerr_wwpn, sizeof(struct lpfc_name));
>                 tmp = cpu_to_be64(tmp);
>                 cnt = scnprintf(cbuf, 32, "0x%016llx\n", tmp);
> -       } else if (dent == phba->debug_InjErrLBA) {
> +       } else if (kind == InjErrLBA) {
>                 if (phba->lpfc_injerr_lba == (sector_t)(-1))
>                         cnt = scnprintf(cbuf, 32, "off\n");
>                 else
> @@ -2417,8 +2417,8 @@ static ssize_t
>  lpfc_debugfs_dif_err_write(struct file *file, const char __user *buf,
>         size_t nbytes, loff_t *ppos)
>  {
> -       struct dentry *dent = file->f_path.dentry;
>         struct lpfc_hba *phba = file->private_data;
> +       int kind = debugfs_get_aux_num(file);
>         char dstbuf[33];
>         uint64_t tmp = 0;
>         int size;
> @@ -2428,7 +2428,7 @@ lpfc_debugfs_dif_err_write(struct file *file, const char __user *buf,
>         if (copy_from_user(dstbuf, buf, size))
>                 return -EFAULT;
>
> -       if (dent == phba->debug_InjErrLBA) {
> +       if (kind == InjErrLBA) {
>                 if ((dstbuf[0] == 'o') && (dstbuf[1] == 'f') &&
>                     (dstbuf[2] == 'f'))
>                         tmp = (uint64_t)(-1);
> @@ -2437,23 +2437,23 @@ lpfc_debugfs_dif_err_write(struct file *file, const char __user *buf,
>         if ((tmp == 0) && (kstrtoull(dstbuf, 0, &tmp)))
>                 return -EINVAL;
>
> -       if (dent == phba->debug_writeGuard)
> +       if (kind == writeGuard)
>                 phba->lpfc_injerr_wgrd_cnt = (uint32_t)tmp;
> -       else if (dent == phba->debug_writeApp)
> +       else if (kind == writeApp)
>                 phba->lpfc_injerr_wapp_cnt = (uint32_t)tmp;
> -       else if (dent == phba->debug_writeRef)
> +       else if (kind == writeRef)
>                 phba->lpfc_injerr_wref_cnt = (uint32_t)tmp;
> -       else if (dent == phba->debug_readGuard)
> +       else if (kind == readGuard)
>                 phba->lpfc_injerr_rgrd_cnt = (uint32_t)tmp;
> -       else if (dent == phba->debug_readApp)
> +       else if (kind == readApp)
>                 phba->lpfc_injerr_rapp_cnt = (uint32_t)tmp;
> -       else if (dent == phba->debug_readRef)
> +       else if (kind == readRef)
>                 phba->lpfc_injerr_rref_cnt = (uint32_t)tmp;
> -       else if (dent == phba->debug_InjErrLBA)
> +       else if (kind == InjErrLBA)
>                 phba->lpfc_injerr_lba = (sector_t)tmp;
> -       else if (dent == phba->debug_InjErrNPortID)
> +       else if (kind == InjErrNPortID)
>                 phba->lpfc_injerr_nportid = (uint32_t)(tmp & Mask_DID);
> -       else if (dent == phba->debug_InjErrWWPN) {
> +       else if (kind == InjErrWWPN) {
>                 tmp = cpu_to_be64(tmp);
>                 memcpy(&phba->lpfc_injerr_wwpn, &tmp, sizeof(struct lpfc_name));
>         } else
> @@ -6160,60 +6160,51 @@ lpfc_debugfs_initialize(struct lpfc_vport *vport)
>                         phba->debug_dumpHostSlim = NULL;
>
>                 /* Setup DIF Error Injections */
> -               snprintf(name, sizeof(name), "InjErrLBA");
>                 phba->debug_InjErrLBA =
> -                       debugfs_create_file(name, S_IFREG|S_IRUGO|S_IWUSR,
> +                       debugfs_create_file_aux_num("InjErrLBA", 0644,
>                         phba->hba_debugfs_root,
> -                       phba, &lpfc_debugfs_op_dif_err);
> +                       phba, InjErrLBA, &lpfc_debugfs_op_dif_err);
>                 phba->lpfc_injerr_lba = LPFC_INJERR_LBA_OFF;
>
> -               snprintf(name, sizeof(name), "InjErrNPortID");
>                 phba->debug_InjErrNPortID =
> -                       debugfs_create_file(name, S_IFREG|S_IRUGO|S_IWUSR,
> +                       debugfs_create_file_aux_num("InjErrNPortID", 0644,
>                         phba->hba_debugfs_root,
> -                       phba, &lpfc_debugfs_op_dif_err);
> +                       phba, InjErrNPortID, &lpfc_debugfs_op_dif_err);
>
> -               snprintf(name, sizeof(name), "InjErrWWPN");
>                 phba->debug_InjErrWWPN =
> -                       debugfs_create_file(name, S_IFREG|S_IRUGO|S_IWUSR,
> +                       debugfs_create_file_aux_num("InjErrWWPN", 0644,
>                         phba->hba_debugfs_root,
> -                       phba, &lpfc_debugfs_op_dif_err);
> +                       phba, InjErrWWPN, &lpfc_debugfs_op_dif_err);
>
> -               snprintf(name, sizeof(name), "writeGuardInjErr");
>                 phba->debug_writeGuard =
> -                       debugfs_create_file(name, S_IFREG|S_IRUGO|S_IWUSR,
> +                       debugfs_create_file_aux_num("writeGuardInjErr", 0644,
>                         phba->hba_debugfs_root,
> -                       phba, &lpfc_debugfs_op_dif_err);
> +                       phba, writeGuard, &lpfc_debugfs_op_dif_err);
>
> -               snprintf(name, sizeof(name), "writeAppInjErr");
>                 phba->debug_writeApp =
> -                       debugfs_create_file(name, S_IFREG|S_IRUGO|S_IWUSR,
> +                       debugfs_create_file_aux_num("writeAppInjErr", 0644,
>                         phba->hba_debugfs_root,
> -                       phba, &lpfc_debugfs_op_dif_err);
> +                       phba, writeApp, &lpfc_debugfs_op_dif_err);
>
> -               snprintf(name, sizeof(name), "writeRefInjErr");
>                 phba->debug_writeRef =
> -                       debugfs_create_file(name, S_IFREG|S_IRUGO|S_IWUSR,
> +                       debugfs_create_file_aux_num("writeRefInjErr", 0644,
>                         phba->hba_debugfs_root,
> -                       phba, &lpfc_debugfs_op_dif_err);
> +                       phba, writeRef, &lpfc_debugfs_op_dif_err);
>
> -               snprintf(name, sizeof(name), "readGuardInjErr");
>                 phba->debug_readGuard =
> -                       debugfs_create_file(name, S_IFREG|S_IRUGO|S_IWUSR,
> +                       debugfs_create_file_aux_num("readGuardInjErr", 0644,
>                         phba->hba_debugfs_root,
> -                       phba, &lpfc_debugfs_op_dif_err);
> +                       phba, readGuard, &lpfc_debugfs_op_dif_err);
>
> -               snprintf(name, sizeof(name), "readAppInjErr");
>                 phba->debug_readApp =
> -                       debugfs_create_file(name, S_IFREG|S_IRUGO|S_IWUSR,
> +                       debugfs_create_file_aux_num("readAppInjErr", 0644,
>                         phba->hba_debugfs_root,
> -                       phba, &lpfc_debugfs_op_dif_err);
> +                       phba, readApp, &lpfc_debugfs_op_dif_err);
>
> -               snprintf(name, sizeof(name), "readRefInjErr");
>                 phba->debug_readRef =
> -                       debugfs_create_file(name, S_IFREG|S_IRUGO|S_IWUSR,
> +                       debugfs_create_file_aux_num("readRefInjErr", 0644,
>                         phba->hba_debugfs_root,
> -                       phba, &lpfc_debugfs_op_dif_err);
> +                       phba, readRef, &lpfc_debugfs_op_dif_err);
>
>                 /* Setup slow ring trace */
>                 if (lpfc_debugfs_max_slow_ring_trc) {
> diff --git a/drivers/scsi/lpfc/lpfc_debugfs.h b/drivers/scsi/lpfc/lpfc_debugfs.h
> index 8d2e8d05bbc0..f319f3af0400 100644
> --- a/drivers/scsi/lpfc/lpfc_debugfs.h
> +++ b/drivers/scsi/lpfc/lpfc_debugfs.h
> @@ -322,6 +322,17 @@ enum {
>                                                  * discovery */
>  #endif /* H_LPFC_DEBUG_FS */
>
> +enum {
> +       writeGuard = 1,
> +       writeApp,
> +       writeRef,
> +       readGuard,
> +       readApp,
> +       readRef,
> +       InjErrLBA,
> +       InjErrNPortID,
> +       InjErrWWPN,
> +};
>
>  /*
>   * Driver debug utility routines outside of debugfs. The debug utility

Reviewed-by: Justin Tee <justin.tee@broadcom.com>

Regards,
Justin

