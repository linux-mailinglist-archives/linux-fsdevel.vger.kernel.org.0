Return-Path: <linux-fsdevel+bounces-6695-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E28EF81B743
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 14:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 204351C2493C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 13:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD555745EB;
	Thu, 21 Dec 2023 13:22:43 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FD873197;
	Thu, 21 Dec 2023 13:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4CDFA68B05; Thu, 21 Dec 2023 14:22:36 +0100 (CET)
Date: Thu, 21 Dec 2023 14:22:36 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, "Darrick J. Wong" <djwong@kernel.org>,
	axboe@kernel.dk, kbusch@kernel.org, sagi@grimberg.me,
	jejb@linux.ibm.com, martin.petersen@oracle.com,
	viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
	jack@suse.cz, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	tytso@mit.edu, jbongio@google.com, linux-scsi@vger.kernel.org,
	ming.lei@redhat.com, jaswin@linux.ibm.com, bvanassche@acm.org
Subject: Re: [PATCH v2 00/16] block atomic writes
Message-ID: <20231221132236.GB26817@lst.de>
References: <20231219052121.GA338@lst.de> <76c85021-dd9e-49e3-80e3-25a17c7ca455@oracle.com> <20231219151759.GA4468@lst.de> <fff50006-ccd2-4944-ba32-84cbb2dbd1f4@oracle.com> <20231221065031.GA25778@lst.de> <b60e39ce-04bf-4ff9-8879-d9e0cf5d84bd@oracle.com> <20231221121925.GB17956@lst.de> <df2b6c6e-6415-489d-be19-7e2217f79098@oracle.com> <20231221125713.GA24013@lst.de> <9bee0c1c-e657-4201-beb2-f8163bc945c6@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9bee0c1c-e657-4201-beb2-f8163bc945c6@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Dec 21, 2023 at 01:18:33PM +0000, John Garry wrote:
>> For SGL-capable devices that would be
>> BIO_MAX_VECS, otherwise 1.
>
> ok, but we would need to advertise that or whatever segment limit. A statx 
> field just for that seems a bit inefficient in terms of space.

I'd rather not hard code BIO_MAX_VECS in the ABI, which suggest we
want to export is as a field.  Network file systems also might have
their own limits for one reason or another.

