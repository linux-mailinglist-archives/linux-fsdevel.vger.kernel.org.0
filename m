Return-Path: <linux-fsdevel+bounces-13324-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA8186E802
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 19:11:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 314721F21BF9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 18:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0022182B9;
	Fri,  1 Mar 2024 18:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HYAVUjPr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2691111C88
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Mar 2024 18:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709316704; cv=none; b=ingBZNRXBgoh2k7hDLG5q6x2VmoPFDhTMv958VtO/NvRcJMFGRdkhIguJlWJrDVwsbOukzgRP3g0zCWdwTnJ0H+jYQjHvw29aSvs2F9rfBo50ph0M6UvaFJBlwqb2Rq35zP58vzBe75rKIvpAErlJSVdArwuVXLrgvs1PdEH/RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709316704; c=relaxed/simple;
	bh=Bvo+T7hmUzJ5Qms4HMkPEmgUCtLs4Dn8Bwwkz86KOdo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=UGVriRANQdvhK9tjd7dlKBHsQCzF7NbOP4+hnrdFmQfbEtFBmXvOrjkm8WFPZcNaNr8zmtVe9micDBgOZrUBmrAGI+9bhv0kiYP3/dQeko1tekubLbYRFhfCEO84Bto9ZPgS5rXQtX/B9td7gmjiaGLQDIviMaYGtsVu0WsymLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HYAVUjPr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709316699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=Bvo+T7hmUzJ5Qms4HMkPEmgUCtLs4Dn8Bwwkz86KOdo=;
	b=HYAVUjPrar/QyQctfg6fomE4YxNlYu2vgsxcFERtCpDdPeSo+jsZ7555UnX+g20kxzXE9F
	1AW3A2cgEcGnKAaTV8JtEs7bDgKQedT2WUvk9Uvn7hqgvShJtBA13ymflGOdoZFxdEkQSs
	Ni5gjUuwVruSvGuUrIp0KEcSJ9oerZY=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632--YrjqpifMPSS8RisMG-Opw-1; Fri, 01 Mar 2024 13:11:38 -0500
X-MC-Unique: -YrjqpifMPSS8RisMG-Opw-1
Received: by mail-yb1-f198.google.com with SMTP id 3f1490d57ef6-dc6b267bf11so2946973276.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Mar 2024 10:11:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709316698; x=1709921498;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bvo+T7hmUzJ5Qms4HMkPEmgUCtLs4Dn8Bwwkz86KOdo=;
        b=mP4iFqJGfU7peaqzYVCUtEQae0PQlWafYYkIUKRru+YAHYlXH1HcARkK2Vnb3GqVai
         zsCijTm1Y6KBAKWsHKC5tTOrE+Mnm/JZeKJa+b7uPRlrOE7QS7702rehY12Zez1cXdGs
         vqRAC9T0AXq5jaX05IAv0FSqcaXvjN/bZWgF0nCVdFdd26c6RIA2IpUGr+BiAgHsKwoe
         bTbxlr2YYSHV9elzQLP1zYw/LqziRw5+eCYZJyAKPtT5b1skg0S59EbP8io4nWRN3UOY
         sOavRsrqzE/f0v+F95rgJbtu09tC53D2D9jVikgIqazb5WJ1p0pKvL6CD1OC3Imnxjy9
         o//g==
X-Gm-Message-State: AOJu0YznuiN7mWvh1Gh0jcmPOrFyVtCbeMVZkLvSiVHBQxWEdhr7SWPs
	1h/wUvUdrUIFWi5gTz6dZTbW2qrnEZAb96iIoFiotbG3V7on2bi2DxzP4wabG+fVYL2C34e4wh6
	rpOGpU1Rd3xb6/ihMLCiXR/dL2BfyLg+AtiPsn4e+hr3c8zrDbUXCzlyunlNczj9lx0cPDmRNx5
	fnTRYhS6RDk70cOZ/mwOlI0YKunD86YU8AlTODJA==
X-Received: by 2002:a25:a385:0:b0:dcb:bff0:72b with SMTP id e5-20020a25a385000000b00dcbbff0072bmr2407710ybi.31.1709316697801;
        Fri, 01 Mar 2024 10:11:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEh7kD0jRFI0//7o0zgO5N7WZddyCu+FvYK6XeLKU9j22qxWq2by/vA8QJLRcsDFlw40IzBr7mU3xq1+1lpI7E=
X-Received: by 2002:a25:a385:0:b0:dcb:bff0:72b with SMTP id
 e5-20020a25a385000000b00dcbbff0072bmr2407631ybi.31.1709316696708; Fri, 01 Mar
 2024 10:11:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 1 Mar 2024 19:11:00 +0100
Message-ID: <CAJaqyWfoE9iapUnZxuzhO7SpsS+uttMQTmX2ArWPH8b7au0csQ@mail.gmail.com>
Subject: [LSF/MM/BPF TOPIC] Cloud filesystem through VDUSE / virtiofs
To: lsf-pc@lists.linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org, Jason Wang <jasowang@redhat.com>, 
	German Maglione <gmaglione@redhat.com>, Stefano Garzarella <sgarzarella@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Hi!

I would like to discuss

Cloud filesystem through VDUSE / virtiofs

I'm developing a POC about accessing the different cloud filesystems
like azure blob [1] or google cloud storage [2] through VDUSE [3].

Doing that allows any workload to access the filesystem the same way,
both if it is running containerized or in a VM. Cases like
confidential computing orlibkrun can benefit about it.

Moreover, accessing through VDUSE allows to skip the kernel FUSE
mediation, potentially unlocking performance benefits.

I could talk about the solution proposed, performance profiling, and
future directions. Any kind of feedback is welcome, and I can include
more information in this thread if you find this interesting.

Thanks!

[1] https://learn.microsoft.com/en-us/azure/storage/blobs/blobfuse2-what-is
[2] https://cloud.google.com/storage/
[3] https://www.redhat.com/en/blog/introducing-vduse-software-defined-datapath-virtio


