Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1D763C44
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2019 21:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729155AbfGITzq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jul 2019 15:55:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:50402 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728991AbfGITzp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jul 2019 15:55:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A985CAC84;
        Tue,  9 Jul 2019 19:55:44 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 1E77D1E4376; Tue,  9 Jul 2019 21:55:35 +0200 (CEST)
Date:   Tue, 9 Jul 2019 21:55:35 +0200
From:   Jan Kara <jack@suse.cz>
To:     Steve Magnani <steve.magnani@digidescorp.com>
Cc:     Jan Kara <jack@suse.cz>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>,
        linux-fsdevel@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] udf: 2.01 interoperability issues with Windows 10
Message-ID: <20190709195535.GA509@quack2.suse.cz>
References: <96e1ea00-ac12-015d-5c54-80a83f08b898@digidescorp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96e1ea00-ac12-015d-5c54-80a83f08b898@digidescorp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi!

On Tue 09-07-19 13:27:58, Steve Magnani wrote:
> Recently I have been exploring Advanced Format (4K sector size)
> and high capacity aspects of UDF 2.01 support in Linux and
> Windows 10. I thought it might be helpful to summarize my findings.
> 
> The good news is that I did not see any bugs in the Linux
> ecosystem (kernel driver + mkudffs).
> 
> The not-so-good news is that Windows has some issues that affect
> interoperability. One of my goals in posting this is to open a
> discussion on whether changes should be made in the Linux UDF
> ecosystem to accommodate these quirks.
> 
> My test setup includes the following software components:
> 
> * mkudffs 1.3 and 2.0
> * kernel 4.15.0-43 and 4.15.0-52
> * Windows 10 1803 17134.829
> * chkdsk 10.0.17134.1
> * udfs.sys 10.0.17134.648
> 
> 
> ISSUE 1: Inability of the Linux UDF driver to mount 4K-sector
>          media formatted by Windows.
> 
> This is because the Windows ecosystem mishandles the ECMA-167
> corner case that requires Volume Recognition Sequence components
> to be placed at 4K intervals on 4K-sector media, instead of the
> 2K intervals required with smaller sectors. The Linux UDF driver
> emits the following when presented with Windows-formatted media:
> 
>   UDF-fs: warning (device sdc1): udf_load_vrs: No VRS found
>   UDF-fs: Scanning with blocksize 4096 failed
> 
> A hex dump of the VRS written by the Windows 10 'format' utility
> yields this:
> 
>   0000: 00 42 45 41 30 31 01 00 00 00 00 00 00 00 00 00  .BEA01..........
>   0800: 00 4e 53 52 30 33 01 00 00 00 00 00 00 00 00 00  .NSR03..........
>   1000: 00 54 45 41 30 31 01 00 00 00 00 00 00 00 00 00  .TEA01..........
> 
> We may want to consider tweaking the kernel UDF driver to
> tolerate this quirk; if so a question is whether that should be
> done automatically, only in response to a mount option or
> module parameter, or only with some subsequent confirmation
> that the medium was formatted by Windows.

Yeah, I think we could do that although it will be a bit painful. I would
do it by default if we found BEA descriptor but not NSR descriptor. We do
already have handling for various quirks of other udf creators so this is
nothing new... I think Palo replied about the rest of the issues you've
found.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
