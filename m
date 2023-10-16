Return-Path: <linux-fsdevel+bounces-379-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF767C9F61
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 08:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1C871C20935
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 06:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D90134A9;
	Mon, 16 Oct 2023 06:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10298460
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 06:17:42 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71204DC;
	Sun, 15 Oct 2023 23:17:41 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 834726732A; Mon, 16 Oct 2023 08:17:37 +0200 (CEST)
Date: Mon, 16 Oct 2023 08:17:37 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Christoph Hellwig <hch@lst.de>,
	Niklas Cassel <Niklas.Cassel@wdc.com>,
	Avri Altman <Avri.Altman@wdc.com>, Bean Huo <huobean@gmail.com>,
	Daejun Park <daejun7.park@samsung.com>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v2 03/15] block: Support data lifetime in the I/O
 priority bitfield
Message-ID: <20231016061737.GA26670@lst.de>
References: <20231005194129.1882245-1-bvanassche@acm.org> <20231005194129.1882245-4-bvanassche@acm.org> <8aec03bb-4cef-9423-0ce4-c10d060afce4@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8aec03bb-4cef-9423-0ce4-c10d060afce4@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Oct 06, 2023 at 05:19:52PM +0900, Damien Le Moal wrote:
> Your change seem to assume that it makes sense to be able to combine CDL with
> lifetime hints. But does it really ? 

Yes, it does.


> CDL is of dubious value for solid state
> media and as far as I know,

No, it's pretty useful and I'd bet my 2 cents that it will eventually
show up in relevant standards and devices.

Even if it wasn't making our user interfaces exclusive would be a
massive pain.

> The other question here if you really want to keep the bit separation approach
> is: do we really need up to 64 different lifetime hints ? While the scsi
> standard allows that much, does this many different lifetime make sense in
> practice ? Can we ever think of a usecase that needs more than say 8 different
> liftimes (3 bits) ? If you limit the number of possible lifetime hints to 8,
> then we can keep 4 bits unused in the hint field for future features.

Yes, I think this is the smoking gun.  We should be fine with a much
more limited number of lifetime hints, i.e. the user interface only
exposes 5 hints, and supporting more in the in-kernel interfaces seems
of rather doubtfuŀ use.

