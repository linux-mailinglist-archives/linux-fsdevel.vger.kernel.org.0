Return-Path: <linux-fsdevel+bounces-57984-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0E7B27A50
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 09:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 290477B0B2F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 07:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC8E1DE4C2;
	Fri, 15 Aug 2025 07:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQv8Ivk8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6572D1EEF9
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Aug 2025 07:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755243951; cv=none; b=af8dqIizwRFaWyxZlw98hVd0c1nxSkAzjvysOeq7GE7DzOadj69B8n8dhDjpmQoMtvq0qugKQsFu/Ik5A3M9EGDWckT+w8pUBcLJ0fasJJ9/tbiOzUOKZ//HhT9pTZbqy1AaAKsb8TBICkA47ESnzhk+lApArrBRcxDTnSSX2BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755243951; c=relaxed/simple;
	bh=f8I/e+hzcJlpvQ6IynmYMRJMlB7/FoKcqWvxhrCAdEE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=M8bOanGmlKA1iVndTNDT1ymXk8cies/6J119hwIam6A/Z/SSEui1VQWgIqeS1Tjo1GYUKki2dZA0OQyVNzAnA4CPAW15w8dsXeuIWNOAbTlRJnhlaPif2koVeoKN/cYnuVADnQ2EC9VgPMlym1jYqJD09zyyCEzqVbKcFxy1xXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EQv8Ivk8; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6188b7550c0so2297145a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Aug 2025 00:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755243948; x=1755848748; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NpwcTqCXLrewrdFisLop1+KmqdpXq+VP37gshD/KJV8=;
        b=EQv8Ivk8XGVthPDwxn2Dwvmj1UQ8BBirMhWqlbk6QuP8dabmlo6CrluopXJDEpU8FW
         vyrIss2yhJ/B3+2wquGgh4HxJpiEsEJjj64ZEevVSo4oed8w1YK9wIfcyVdqUjl0JVPv
         /HqTzitw7bJOeNwdan+spm92nwS7AehF6RRwMtbiXGGodFpZF5zyB3IyrA485eXHNl4i
         KNTUWAQbVAY8BUAoo5BCCAVwtBLx4vm7zl12iNI3KPGKMlvysatXey+E51LGYk4Yffsb
         vbJrUJO8ZOGthy88urFiDX6kVhYtW57Sz6TMA5YqvGqLnIZU46KoKYsojOHmcmoP6d5/
         /C0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755243948; x=1755848748;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NpwcTqCXLrewrdFisLop1+KmqdpXq+VP37gshD/KJV8=;
        b=hOW89d/pj74wgfetRfCq/PwZJKyhdAIbwj2C7lR5TxyG7RYx9csLYaELicu69S/m+/
         F4SgnYmPZIiEW3uifCu4z1N1CxoKMg8Vk+JNURXXPupZIKZ07j+UqmSkZgl7CI/DoQTO
         QgCa8LBwPe1OwtagU7MFL6J4wowFOy5joEXmrt3csJUfVa4WRlbzJ6eKA8EGgdCe44dq
         5duPcXzFkMQd99wGOd536MHkzSYuk9axeqQ8dcfhtC16ks/WKI++cHU+ZOuwujE52smh
         89WjDQ+MHelMQLCN4jAhTpLQCHJ3WLvopnvXN5wTsyN+oLcsf1Yjw71kHJrj7Y47cHZW
         s4gw==
X-Gm-Message-State: AOJu0YzDOu6uvREzMG5nwD6JG5VkGayx8V6aW9ilSHIZ9q0C2He//2Kg
	IRpCxo+uZ6nCM9X1y+fhxn20riQOnxnjzz1CTlaZc/OA77PZO9H2SON3g9i8OemOAl393b/eOwl
	nHkhISXxsNV2rBOy5dgTasQMoc8JBcavf7qzc10k=
X-Gm-Gg: ASbGncsbYULL0lL68iKrUceCgEVp3TkQqEjF+pIJlrwI3AYHBayRE7pfYq4GQLHwu5T
	12to8ijzNJIgPtxwPjr3Df3fvPUD5EUJhT/VEApGeq9pICmy7UXg1WRo8w+LAW9wMkM3qZ8czP0
	ZoomwH5hBrGelWnBLo/vqt6kd4D4ORyc2kA0VHyCscOdRky31VYf6tfCBn3zwx3IG4fMy5nrUxU
	IazKA==
X-Google-Smtp-Source: AGHT+IGuogmmIAwoug3BD3vbMtDLxm1351hRY3/Gx3RxJ4q6ParSI/gI5pHpfnPJEkjYLIisWTRILbzF53TIC+9+rl4=
X-Received: by 2002:a17:907:9627:b0:af2:4a7e:ad64 with SMTP id
 a640c23a62f3a-afcdc1f8f7cmr99144866b.2.1755243947529; Fri, 15 Aug 2025
 00:45:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Gang He <dchg2000@gmail.com>
Date: Fri, 15 Aug 2025 15:45:34 +0800
X-Gm-Features: Ac12FXxvUM46vJAli0urk1XHCGiB3Bji7o830miME-1cG2Muqkncbx6SfqHSIlA
Message-ID: <CAGmFzScM+UFXCuw5F3B3rZ8iFFyZxwSwBHJD6XwPnHVtqr5JMg@mail.gmail.com>
Subject: Fuse over io_uring mode cannot handle iodepth > 1 case properly like
 the default mode
To: Bernd Schubert <bernd@bsbernd.com>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Bernd,

Sorry for interruption.
I tested your fuse over io_uring patch set with libfuse null example,
the fuse over io_uring mode has better performance than the default
mode. e.g., the fio command is as below,
fio -direct=1 --filename=/mnt/singfile --rw=read  -iodepth=1
--ioengine=libaio --bs=4k --size=4G --runtime=60 --numjobs=1
-name=test_fuse1

But, if I increased fio iodepth option, the fuse over io_uring mode
has worse performance than the default mode. e.g., the fio command is
as below,
fio -direct=1 --filename=/mnt/singfile --rw=read  -iodepth=4
--ioengine=libaio --bs=4k --size=4G --runtime=60 --numjobs=1
-name=test_fuse2

The test result showed the fuse over io_uring mode cannot handle this
case properly. could you take a look at this issue? or this is design
issue?

I went through the related source code, I do not understand each
fuse_ring_queue thread has only one  available ring entry? this design
will cause the above issue?
the related code is as follows,
dev_uring.c
1099
1100     queue = ring->queues[qid];
1101     if (!queue) {
1102         queue = fuse_uring_create_queue(ring, qid);
1103         if (!queue)
1104             return err;
1105     }
1106
1107     /*
1108      * The created queue above does not need to be destructed in
1109      * case of entry errors below, will be done at ring destruction time.
1110      */
1111
1112     ent = fuse_uring_create_ring_ent(cmd, queue);
1113     if (IS_ERR(ent))
1114         return PTR_ERR(ent);
1115
1116     fuse_uring_do_register(ent, cmd, issue_flags);
1117
1118     return 0;
1119 }


Thanks
Gang

