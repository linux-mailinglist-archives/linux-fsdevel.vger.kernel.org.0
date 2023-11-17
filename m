Return-Path: <linux-fsdevel+bounces-3045-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCBA7EF7A0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 19:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FC4E1C209DB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 18:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288A74317E;
	Fri, 17 Nov 2023 18:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CvRwvpjY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85037C5
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Nov 2023 10:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700247505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AQKHlXidiDt+M3MxLcZzVRnRIoQZQv44Ty67kKbq6WQ=;
	b=CvRwvpjYkgEwS2LoEcNh4AlJEbj7IL4gZXv7jA2s3akmNh5WkJUaokpKKNqtlQEdv+QCp4
	RygFYHKIbY5bYe5INVsNqSrrincpv0NG6wGjREZCDiXot+I4oS727xzo/Er2ljiamL1YCC
	MDnJXe5vjfmDQ/YdTcwpuWTdDtV0/Y4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-i7KE9BHsO8qyM69wfjbAvw-1; Fri, 17 Nov 2023 13:58:24 -0500
X-MC-Unique: i7KE9BHsO8qyM69wfjbAvw-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6716c2696c7so6658686d6.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Nov 2023 10:58:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700247504; x=1700852304;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AQKHlXidiDt+M3MxLcZzVRnRIoQZQv44Ty67kKbq6WQ=;
        b=cdpCgGGnRBcYrfoK+XKvRq+ZqnP76/Ix/2WWdlc9bUtdXngH1T0dKNjbHn+oB5UzEM
         YBvf0d8hbvf4NG8Tex9fDu0rLswBHhr4QYw9HA/7WAwEYFKNvRx3YoYO2JGYkgfn2VdF
         q0Rzedf4EV3wyg/KocYREKxIN+hwP3I38G0/zMNyfKRGRs1YptEPdki4WqYp+z2nGhZ6
         mS/ynfo2EyP9DGUknNTIW/3NzjMPWX00PgU9uGO52aHq601tdn7V9hgbULKfcjd8rs9I
         KgztlpeIXoD2NKQJBftKWhOLlQEvT7TozpiD8jbhAHMJX0N8WmAJ/xoIlZmqEmEsq1vV
         OeYw==
X-Gm-Message-State: AOJu0YzLLIu9zEjM2i6F6zPVIahivPl2VWc+bt6qNaoKkqFo6K4UXegh
	6lNdDh0Fp/nzbvfRk6ldWtyVT2N0cOfEmk24DOvBGXq3B53wsrdTrNUNHkvkp5MD+8APBMGRMfw
	gWrSUx9Kq0GMwbdbZEnac4k4UQJISTeiTvg==
X-Received: by 2002:ad4:5ba6:0:b0:66d:1012:c16a with SMTP id 6-20020ad45ba6000000b0066d1012c16amr13083900qvq.1.1700247503843;
        Fri, 17 Nov 2023 10:58:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHckEqremfB/8sydMVrOBFf/+LIb067OixiZVjVDuDKvH+dYSEUbT6n8vtpqL4tn+1ktCwT8w==
X-Received: by 2002:ad4:5ba6:0:b0:66d:1012:c16a with SMTP id 6-20020ad45ba6000000b0066d1012c16amr13083892qvq.1.1700247503572;
        Fri, 17 Nov 2023 10:58:23 -0800 (PST)
Received: from [172.31.1.12] ([70.109.136.127])
        by smtp.gmail.com with ESMTPSA id o1-20020a056214180100b00656e2464719sm840783qvw.92.2023.11.17.10.58.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Nov 2023 10:58:23 -0800 (PST)
Message-ID: <a870ef0f-99be-43e3-9596-8b28938fd48f@redhat.com>
Date: Fri, 17 Nov 2023 13:58:22 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Steve Dickson <steved@redhat.com>
Subject: ANNOUNCE: nfs-utils-2.6.4 released.
To: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

A fairly minor release... A number of bug fixes in
mountd, export and gssd. A regression in the Junction
code was also fixed as well as a few systemd and doc
fixes.

The tarballs can be found in
   https://www.kernel.org/pub/linux/utils/nfs-utils/2.6.4/
or
   http://sourceforge.net/projects/nfs/files/nfs-utils/2.6.4

The change log is in
    https://www.kernel.org/pub/linux/utils/nfs-utils/2.6.4/2.6.4-Changelog
or
    http://sourceforge.net/projects/nfs/files/nfs-utils/2.6.4/

The git tree is at:
    git://linux-nfs.org/~steved/nfs-utils

Please send comments/bugs to linux-nfs@vger.kernel.org

steved.


