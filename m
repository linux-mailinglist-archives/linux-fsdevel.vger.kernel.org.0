Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 444B32D5992
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Dec 2020 12:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731945AbgLJLoW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Dec 2020 06:44:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:47110 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727968AbgLJLoM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Dec 2020 06:44:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 31382AD5A;
        Thu, 10 Dec 2020 11:43:26 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 5CF631E0F6A; Thu, 10 Dec 2020 12:25:11 +0100 (CET)
Date:   Thu, 10 Dec 2020 12:25:11 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: FAN_CREATE_SELF
Message-ID: <20201210112511.GB24151@quack2.suse.cz>
References: <CAOQ4uxiOMeGD212Lt6_udbDb6f6M+dt4vUrZz_2Qt-tuvAt--A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxiOMeGD212Lt6_udbDb6f6M+dt4vUrZz_2Qt-tuvAt--A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Amir!

On Wed 09-12-20 21:14:53, Amir Goldstein wrote:
> I have a use case with a listener that uses FAN_REPORT_FID mode.
> (fid is an index to a db).
> Most of the time fid can be resolved to the path and that is sufficient.
> If it cannot, the file will be detected by a later dir scan.
> 
> I find that with most of the events this use case can handle the events
> efficiently without the name info except for FAN_CREATE.
> 
> For files, with most applications, FAN_CREATE will be followed by
> some other event with the file fid, but it is not guaranteed.
> For dirs, a single FAN_CREATE event is more common.
> 
> I was thinking that a FAN_CREATE_SELF event could be useful in some
> cases, but I don't think it is a must for closing functional gaps.
> For example, another group could be used with FAN_REPORT_DFID_NAME
> to listen on FAN_CREATE events only, or on FAN_CREATE (without name)
> the dir can be scanned, but it is not ideal.
> 
> Before composing a patch I wanted to ask your opinion on the
> FAN_CREATE_SELF event. Do you have any thoughts on this?

Well, generating FAN_CREATE_SELF event is kind of odd because you have no
mark placed on the inode which is being created. So it would seem more
logical to me that dirent events - create, move, delete - could provide you
with a FID of object that is affected by the operation (i.e., where DFID +
name takes you). That would have to be another event info type.

BTW, what's the problem with just using FAN_REPORT_DFID_NAME? You don't
want to pay the cost of looking up & copying DFID+name instead of FID for
cases you don't care about? Is there such a significant difference?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
