Return-Path: <linux-fsdevel+bounces-35664-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F264A9D6D54
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 10:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC5462814AD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 09:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B38183098;
	Sun, 24 Nov 2024 09:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MtyUFx5I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3645D33987;
	Sun, 24 Nov 2024 09:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732441704; cv=none; b=ZEckF7mEiD9omnqN3WO6uXnxGy9Yd1iS0XCI8D+hv59g3+DHr/RRdbmxumLO/luiW+PKZJeXgZf6mZLrPmqa0IsHPZpCDilb7+ebo6PjcFf4Ivg7LcNhd4zTa7+uCJSpngxDrp3LFquqIKSdisZ+dxsIKDDIMGYNDbKw8QE9Z+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732441704; c=relaxed/simple;
	bh=KqCGmrT2jLynqDzCmP910Fe66cxrqhAbO+Lk9tnciqE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GJ1P50VlBBO0bGYOn2QGbzAvjEvdqWoufZVHZmapVxstjzc/7QjJubvMxhOrOhmwoVXx+9YifchXbZ9T2pt9l8ZgKnQMHsfH7oCP1/tWfgXecIYDHGTpbQff0bSetNwp2XwlkvMhliXtUJQ9qPoF4pZOTAJRLR4CJHG1655Nf98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MtyUFx5I; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21290973bcbso33875825ad.3;
        Sun, 24 Nov 2024 01:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732441702; x=1733046502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pMAN3HfmkHHfUUVQfaiI8Aof7137pvCBcSCUXfcdjDw=;
        b=MtyUFx5I5ja53s8SpOTq7Abh0FSgoeX8+Jcw4PPXWh2niJFQwguQD/jaSAl6dEUPi+
         uOLgmjjqo7cZoJVoQwq/CuhG3gwwMBP9rQgRyPl+1ObAWigKF5APvAK6Yd9b0/A7fYsV
         OvLOSSdVEWJ0QzjndtYxkCWqwP1W0iTenPyIQRD9Xn7DUocUi2QL9YkN+909e45rg6A2
         S+KDqlXha4YYblnv+AXFJO8r1h3eg8sQxzEtoAVk5t0df5zqCZ1mZVXno9E6bA3uLy89
         D6+JiVms6FdZQ+Q8ZCE7AHfgmcOeTfY2Ilg/UoAYo+neYh4rFg4wF6gyuz13huqxOdYX
         pzkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732441702; x=1733046502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pMAN3HfmkHHfUUVQfaiI8Aof7137pvCBcSCUXfcdjDw=;
        b=gghX8eJFmygxu7/PmgZvafs2k+rV2jBoFX7b0/DmDuZU3z/diZybX8qCKlO1uN/lhz
         KmZ0hSg5vC/bTSfTOBGAw8XBRXXXOfTuE1ZQxhP6EQqo3q+nDHuApqj+x0/ZzvT63VHW
         bkJ+T/rVkRiq2mgWlLxVzuaJhAQ+FUmUKgmRKkx9lX9Uhketw65KyGvmOXqnsiXL5JMj
         6uk9fXERtUMGU0gvkuCROvtuyF52AqM6f7vYXMpkU3ocq1k1mlYdo26h8c4vlwhpxnx5
         c3K8IZYvnXzJow1sYnWT531oPima+AJgR0MeMIWwvwtWTSvcYVfbtRjVEQGEGFWxyJRP
         OnIw==
X-Forwarded-Encrypted: i=1; AJvYcCUfvHkIkLPetn1W/5Bqxi6/JvvN9pfyQw8SxEEEChPkeIn/tqVz9tyXkNE0EZnyDx10Y0aheoi8T+1qB5aZ@vger.kernel.org, AJvYcCUgFrdmdks6RHqOB/Qt023zwkerTT9hDinj8OADl4hySOn2c3GDGf2MzGpRu0NxRUjkrXMJPnIHRMfKjkZ5@vger.kernel.org
X-Gm-Message-State: AOJu0YzrrvEpGxTcQ6/GkwE9NeUN8+8M30izYN/+/OoX64d20H16/qse
	xT/V1SAdrLzf/4jXUUVhbMRmjIOUECQA5hYGFx7+murLm0d0ENL3
X-Gm-Gg: ASbGnct9PL4l1dwErzhuEFrYmVEXi8ZUOlC0m2xLCxXZWLS8ixN31ndDtppVrd4gEOn
	GAuBRiiXh9n7+nlH+YiDihYFQ0U2RYq617mSkuBzBb9E8elDTQs4puFBJtEjjROgqL9CrrvwU+D
	yl21o8r2FbdGBLiZm3JGKMTB1zTfwGWJ7TYegzNrMNOntnoEASNadt1y7HNcBMVY37VSBZ5ZAvV
	b9P14+hJvF78n1p30cEEIziUVUr0sLk+e58g4EavCO3h4gNZR5lG6F9vch9njKeSYxrTYOGZh2q
	vRfS98vWURYvVQ==
X-Google-Smtp-Source: AGHT+IGmDwNx+aFTSBpvKoQ/8uhEPo0ApQEbwxP3MxIFx9Y1eWEcDh/S9N6QM6UCqUPtuxZ8nzAkSw==
X-Received: by 2002:a17:903:258a:b0:211:aa9e:b808 with SMTP id d9443c01a7336-2129f51d393mr91978595ad.6.1732441702204;
        Sun, 24 Nov 2024 01:48:22 -0800 (PST)
Received: from localhost.localdomain ([14.116.239.34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dba3588sm43913925ad.86.2024.11.24.01.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2024 01:48:21 -0800 (PST)
From: Jinliang Zheng <alexjlzheng@gmail.com>
X-Google-Original-From: Jinliang Zheng <alexjlzheng@tencent.com>
To: viro@zeniv.linux.org.uk
Cc: adobriyan@gmail.com,
	alexjlzheng@gmail.com,
	alexjlzheng@tencent.com,
	brauner@kernel.org,
	flyingpeng@tencent.com,
	jack@suse.cz,
	joel.granados@kernel.org,
	kees@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mcgrof@kernel.org
Subject: Re: [PATCH 0/6] Maintain the relative size of fs.file-max and fs.nr_open
Date: Sun, 24 Nov 2024 17:48:13 +0800
Message-Id: <20241124094813.1021293-1-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20241123193227.GT3387508@ZenIV>
References: <20241123193227.GT3387508@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 23 Nov 2024 19:32:27 +0000, Al Viro wrote:
> On Sat, Nov 23, 2024 at 06:27:30PM +0000, Al Viro wrote:
> > On Sun, Nov 24, 2024 at 02:08:55AM +0800, Jinliang Zheng wrote:
> > > According to Documentation/admin-guide/sysctl/fs.rst, fs.nr_open and
> > > fs.file-max represent the number of file-handles that can be opened
> > > by each process and the entire system, respectively.
> > > 
> > > Therefore, it's necessary to maintain a relative size between them,
> > > meaning we should ensure that files_stat.max_files is not less than
> > > sysctl_nr_open.
> > 
> > NAK.
> > 
> > You are confusing descriptors (nr_open) and open IO channels (max_files).
> > 
> > We very well _CAN_ have more of the former.  For further details,
> > RTFM dup(2) or any introductory Unix textbook.
> 
> Short version: there are 3 different notions -
> 	1) file as a collection of data kept by filesystem. Such things as
> contents, ownership, permissions, timestamps belong there.
> 	2) IO channel used to access one of (1).  open(2) creates such;
> things like current position in file, whether it's read-only or read-write
> open, etc. belong there.  It does not belong to a process - after fork(),
> child has access to all open channels parent had when it had spawned
> a child.  If you open a file in parent, read 10 bytes from it, then spawn
> a child that reads 10 more bytes and exits, then have parent read another
> 5 bytes, the first read by parent will have read bytes 0 to 9, read by
> child - bytes 10 to 19 and the second read by parent - bytes 20 to 24.
> Position is a property of IO channel; it belongs neither to underlying
> file (otherwise another process opening the file and reading from it
> would play havoc on your process) nor to process (otherwise reads done
> by child would not have affected the parent and the second read from
> parent would have gotten bytes 10 to 14).  Same goes for access mode -
> it belongs to IO channel.

I'm sorry that I don't know much about the implementation of UNIX, but
specific to the implementation of Linux, struct file is more like a
combination of what you said 1) and 2).

But I see your point, I missed the dup() case. dup() will occupy the
element position of the fdtable->fd array, but will not create a new
struct file.

Thank you.
Jinliang Zheng

> 	3) file descriptor - a number that has a meaning only in context
> of a process and refers to IO channel.	That's what system calls use
> to identify the IO channel to operate upon; open() picks a descriptor
> unused by the calling process, associates the new channel with it and
> returns that descriptor (a number) to caller.  Multiple descriptors can
> refer to the same IO channel; e.g. dup(fd) grabs a new descriptor and
> associates it with the same IO channel fd currently refers to.
> 
> 	IO channels are not directly exposed to userland, but they are
> very much present in Unix-style IO API.  Note that results of e.g.
> 	int fd1 = open("/etc/issue", 0);
> 	int fd2 = open("/etc/issue", 0);
> and
> 	int fd1 = open("/etc/issue", 0);
> 	int fd2 = dup(fd1);
> are not identical, even though in both cases fd1 and fd2 are opened
> descriptors and reading from them will access the contents of the
> /etc/issue; in the former case the positions being accessed by read from
> fd1 and fd2 will be independent, in the latter they will be shared.
> 
> 	It's really quite basic - Unix Programming 101 stuff.  It's not
> just that POSIX requires that and that any Unix behaves that way,
> anything even remotely Unix-like will be like that.
> 
> 	You won't find the words 'IO channel' in POSIX, but I refuse
> to use the term they have chosen instead - 'file description'.	Yes,
> alongside with 'file descriptor', in the contexts where the distinction
> between these notions is quite important.  I would rather not say what
> I really think of those unsung geniuses, lest CoC gets overexcited...
> 
> 	Anyway, in casual conversations the expression 'opened file'
> usually refers to that thing.  Which is somewhat clumsy (sounds like
> 'file on filesystem that happens to be opened'), but usually it's
> good enough.  If you need to be pedantic (e.g. when explaining that
> material in aforementioned Unix Programming 101 class), 'IO channel'
> works well enough, IME.

