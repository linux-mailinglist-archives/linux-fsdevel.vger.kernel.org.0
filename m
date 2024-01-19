Return-Path: <linux-fsdevel+bounces-8298-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 010FA832725
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 10:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A48152855A3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 09:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25923C6B3;
	Fri, 19 Jan 2024 09:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="QdPmAUGu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A7C3C09F
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jan 2024 09:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705658304; cv=none; b=LQlfRHglMw72PoTVf+et/n1ffT6bG6oBVKwm87dyazd4RExuXPd0aFHbfgkgL2Eh45J7qFq42Q0+Kh19yjnhRUM3KPyVF7z8yEv9cg0l95nETG5JAxq0ZdzzrhxS3DnUsl/1V76CsYpmgBmnIbrlGRjGi+TXU+80cJzcI5JvvT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705658304; c=relaxed/simple;
	bh=pbJJxh0zojzHS7i20y0ZwmEIBzLcxdA0whojeVWe1PY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=eI9BvIjehAKMFLfN2z1O0LAZ/J5C8QPnsKE+3dwyWR9HpLOfALJSnHnO6VEzIiFsj0HLki43GZYhIVwCxYuwvPVgF2K8H4/be6WEORdwHs8iukssFOzJe8+dmuydGXGnSce0yS8G/4uhcXE9Isi6a3MYk9mqzCSo/oGXdH/8MO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=QdPmAUGu; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240119095814epoutp049582ca85345e0fa6e0272d17b0b530bd~rty6H7DtU0767407674epoutp04u
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jan 2024 09:58:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240119095814epoutp049582ca85345e0fa6e0272d17b0b530bd~rty6H7DtU0767407674epoutp04u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1705658294;
	bh=Z8cj8yi3f/yHfGmWyRmLF9hRdnCFp9eAZlsSvzZqRGg=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=QdPmAUGuK94oO/YGq3Uv6BRjW97EFyCFHopcn0ZgsGFXrFNbeQ929zxuBGTdTVBcb
	 EFmtnhNjiI8dAv7BFf4FLGstGM/FyQdUEaxMctZd6whLzUinZ7ejbkjpcsNta1slfb
	 hh4WHsip4CskhhPbAnYxYTmFyDX2Ot1hI+kqJxXQ=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240119095813epcas5p33065cc4ff14476102f05bf8b5164fd5f~rty5pl1jT2592325923epcas5p3Q;
	Fri, 19 Jan 2024 09:58:13 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.177]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4TGZn01Swgz4x9Q1; Fri, 19 Jan
	2024 09:58:12 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	E7.6E.08567.4B74AA56; Fri, 19 Jan 2024 18:58:12 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240119095811epcas5p2155a2273662e73131c45402e9301f094~rty3xRCuz2298822988epcas5p2_;
	Fri, 19 Jan 2024 09:58:11 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240119095811epsmtrp13b53e0bc56899b1f241820732cf61726~rty3wO1IX1734417344epsmtrp1I;
	Fri, 19 Jan 2024 09:58:11 +0000 (GMT)
X-AuditID: b6c32a44-617fd70000002177-10-65aa47b4c138
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	F0.24.18939.3B74AA56; Fri, 19 Jan 2024 18:58:11 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240119095810epsmtip2f1fef4fdef921138c785fdf354d7754c~rty2TfYIL2428524285epsmtip22;
	Fri, 19 Jan 2024 09:58:10 +0000 (GMT)
Message-ID: <9b0521a9-c0d6-693b-3596-c1110c497173@samsung.com>
Date: Fri, 19 Jan 2024 15:28:09 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [LSF/MM/BPF TOPIC] : Flexible Data Placement (FDP) availability
 for kernel space file systems
Content-Language: en-US
To: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>, Viacheslav
	Dubeyko <slava@dubeyko.com>
Cc: lsf-pc@lists.linux-foundation.org, Linux FS Devel
	<linux-fsdevel@vger.kernel.org>, Adam Manzanares <a.manzanares@samsung.com>,
	linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, slava@dubeiko.com, Bart Van Assche
	<bvanassche@acm.org>
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20240117115812.e46ihed2qt67wdue@ArmHalley.local>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLJsWRmVeSWpSXmKPExsWy7bCmhu4W91WpBk1rOCymH1a0mPbhJ7PF
	4zuf2S323tK22LP3JIvF/GVP2S26r+9gs9j3ei+zxafLC4HEltlMDlwel694ezx6cpDV4+D6
	Nywem5fUe0y+sZzRo2/LKkaPz5vkAtijsm0yUhNTUosUUvOS81My89JtlbyD453jTc0MDHUN
	LS3MlRTyEnNTbZVcfAJ03TJzgG5TUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak5BSY
	FOgVJ+YWl+al6+WlllgZGhgYmQIVJmRnLGp1KLglXDHp+zn2BsZv/F2MnBwSAiYSG+etYO5i
	5OIQEtjNKHFo22R2COcTo8SvLYdZQKrAnPebfWE6Lq15yApRtJNRouvRLTYI5y2jRPOFW0Dt
	HBy8AnYS8085gzSwCKhKLFyznw3E5hUQlDg58wnYUFGBJIlfV+cwgpQLC+RItE/xBgkzC4hL
	3HoynwnEFhHIkFj67CULyHhmgdlMEt9edbGC1LMJaEpcmFwKUsMJtGnKt2NMEL3yEs1bZ4N9
	IyGwlENi1qQ2FoijXSRO9bUwQtjCEq+Ob2GHsKUkXva3QdnJEpdmnmOCsEskHu85CGXbS7Se
	6mcG2csMtHf9Ln2IXXwSvb+fMIGEJQR4JTrahCCqFSXuTXrKCmGLSzycsQTK9pD48GQiNGzX
	M0msmHONZQKjwiykUJmF5P1ZSN6ZhbB5ASPLKkbJ1ILi3PTUZNMCw7zUcnhsJ+fnbmIEp1st
	lx2MN+b/0zvEyMTBeIhRgoNZSYSXX3VVqhBvSmJlVWpRfnxRaU5q8SFGU2D0TGSWEk3OByb8
	vJJ4QxNLAxMzMzMTS2MzQyVx3tetc1OEBNITS1KzU1MLUotg+pg4OKUamA6e/zez3l43bf3H
	4s5d7RmXVuycsMyVNb5X4kr1N9veWbU3zxyR0ktiY9LvPhumKfQonnPig2nXp6+Mv/CTZf3E
	lVf6vzI5PqusXno2sJdZa3fmhqBAndYtd18fceTUC59uuN7PceFV3+1WHVdWzLqoczxoUl2T
	m/flHdxL5XVmZSzzzezYOv2efI230eJnKYsvhJdoXOO9f9qW/XFS2frcvQ9meeiL+jbc/3zk
	DgfvAfWg6qnJhiLvN3FmNj06cmLKTqbL/f83V4kVcC6VjztbP/mgzf4ow7ePmOI1q5e9tvwW
	HHs9T18nO+ebUc1OzRn6se82Mxf0Ltp/6WRSwhqhPW3c5RG/pnwK+Vn+4Y4SS3FGoqEWc1Fx
	IgA8TVaoQAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjkeLIzCtJLcpLzFFi42LZdlhJXnez+6pUg97TehbTDytaTPvwk9ni
	8Z3P7BZ7b2lb7Nl7ksVi/rKn7Bbd13ewWex7vZfZ4tPlhUBiy2wmBy6Py1e8PR49OcjqcXD9
	GxaPzUvqPSbfWM7o0bdlFaPH501yAexRXDYpqTmZZalF+nYJXBmLWh0KbglXTPp+jr2B8Rt/
	FyMnh4SAicSlNQ9Zuxi5OIQEtjNK9J2+xgyREJdovvaDHcIWllj57zk7RNFrRollJ3YDORwc
	vAJ2EvNPOYPUsAioSixcs58NxOYVEJQ4OfMJC4gtKpAksed+IxNIubBAjkT7FG+QMDPQ+FtP
	5jOB2CICGRI/Pz5nARnPLDCbSeLqxwmMELvWM0lsf/2WFaSZTUBT4sLkUpAGTqC1U74dY4IY
	ZCbRtbWLEcKWl2jeOpt5AqPQLCRnzEKybxaSlllIWhYwsqxiFE0tKM5Nz00uMNQrTswtLs1L
	10vOz93ECI4qraAdjMvW/9U7xMjEwXiIUYKDWUmEl191VaoQb0piZVVqUX58UWlOavEhRmkO
	FiVxXuWczhQhgfTEktTs1NSC1CKYLBMHp1QDk6vtckOW1GO++6ffcmsOTn3Or624pHiRH49r
	7/l1zJN7zIXuSknsPj7nhszZJPfKqYltK97Vrf5qxCL6LrnihJvcw6uq0tt7C//uzVs+m+Uc
	931rp51Z+6/pbG02vrlf5MbXXwKzKmcZBOVGsi+tidw+QW771+5vXf1qUsc+Pd90p2WidIzV
	mlMGXLuzODriEw894Pg1MzLSlyGntfbd5Jv6Je96E0+prfli/PZ7zZ2gJVOlvvyR4kjWVjBw
	0NrcyzHBreDZ/yOzeepjZodXlBTNWN7eF54Xt3HBjebYcIuSNaHstmdrn50/1lf/Y+erdAG3
	3siENzNOXM7N2JZQ/ims7v2jn+FaKrpuXNuPKLEUZyQaajEXFScCAGcPtaAZAwAA
X-CMS-MailID: 20240119095811epcas5p2155a2273662e73131c45402e9301f094
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240115084656eucas1p219dd48243e2eaec4180e5e6ecf5e8ad9
References: <CGME20240115084656eucas1p219dd48243e2eaec4180e5e6ecf5e8ad9@eucas1p2.samsung.com>
	<20240115084631.152835-1-slava@dubeyko.com>
	<20240115175445.pyxjxhyrmg7od6sc@mpHalley-2.localdomain>
	<86106963-0E22-46D6-B0BE-A1ABD58CE7D8@dubeyko.com>
	<20240117115812.e46ihed2qt67wdue@ArmHalley.local>

On 1/17/2024 5:28 PM, Javier González wrote:
> On 16.01.2024 11:39, Viacheslav Dubeyko wrote:
>>
>>
>>> On Jan 15, 2024, at 8:54 PM, Javier González 
>>> <javier.gonz@samsung.com> wrote:
>>>
>>> On 15.01.2024 11:46, Viacheslav Dubeyko wrote:
>>>> Hi Javier,
>>>>
>>>> Samsung introduced Flexible Data Placement (FDP) technology
>>>> pretty recently. As far as I know, currently, this technology
>>>> is available for user-space solutions only. I assume it will be
>>>> good to have discussion how kernel-space file systems could
>>>> work with SSDs that support FDP technology by employing
>>>> FDP benefits.
>>>
>>> Slava,
>>>
>>> Thanks for bringing this up.
>>>
>>> First, this is not a Samsung technology. Several vendors are building
>>> FDP and several customers are already deploying first product.
>>>
>>> We enabled FDP thtough I/O Passthru to avoid unnecesary noise in the
>>> block layer until we had a clear idea on use-cases. We have been
>>> following and reviewing Bart's write hint series and it covers all the
>>> block layer and interface needed to support FDP. Currently, we have
>>> patches with small changes to wire the NVMe driver. We plan to submit
>>> them after Bart's patches are applied. Now it is a good time since we
>>> have LSF and there are also 2 customers using FDP on block and file.
>>>
>>>>
>>>> How soon FDP API will be available for kernel-space file systems?
>>>
>>> The work is done. We will submit as Bart's patches are applied.
>>>
>>> Kanchan is doing this work.
>>>
>>>> How kernel-space file systems can adopt FDP technology?
>>>
>>> It is based on write hints. There is no FS-specific placement decisions.
>>> All the responsibility is in the application.
>>>
>>> Kanchan: Can you comment a bit more on this?

Application-specific placement (with write-hints) is almost 
FS-independent, and some applications (that require more control or 
predictable outcomes across file systems) prefer that.
It also punts the responsibility of accuracy on the application side 
(and kernel prefers that at times).

FS-specific placement is the next step, but it needs to be 
discussed/done at each FS level. The effort (and likely outcome, too) 
will vary.

Also, we will need to avoid the hint collision between the user and 
kernel. Either by extending/reserving a different range of hints 
exclusively for in-kernel use or take the F2FS approach (i.e., mount 
option that keeps hints for the user or FS use but not both).

