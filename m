Return-Path: <linux-fsdevel+bounces-249-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E11227C8258
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 11:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D1F4282A60
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 09:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F961119E;
	Fri, 13 Oct 2023 09:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F02711187
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Oct 2023 09:41:30 +0000 (UTC)
X-Greylist: delayed 8011 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 13 Oct 2023 02:41:13 PDT
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D48121;
	Fri, 13 Oct 2023 02:41:12 -0700 (PDT)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4S6M2Q36gSz4xVbr;
	Fri, 13 Oct 2023 17:41:02 +0800 (CST)
Received: from szxlzmapp04.zte.com.cn ([10.5.231.166])
	by mse-fl2.zte.com.cn with SMTP id 39D9esWV078823;
	Fri, 13 Oct 2023 17:40:54 +0800 (+08)
	(envelope-from cheng.lin130@zte.com.cn)
Received: from mapi (szxlzmapp07[null])
	by mapi (Zmail) with MAPI id mid14;
	Fri, 13 Oct 2023 17:40:57 +0800 (CST)
Date: Fri, 13 Oct 2023 17:40:57 +0800 (CST)
X-Zmail-TransId: 2b09652910a934b-6def0
X-Mailer: Zmail v1.0
Message-ID: <202310131740571821517@zte.com.cn>
In-Reply-To: <20231013-tyrannisieren-umfassen-0047ab6279aa@brauner>
References: 202310131527303451636@zte.com.cn,20231013-tyrannisieren-umfassen-0047ab6279aa@brauner
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <cheng.lin130@zte.com.cn>
To: <brauner@kernel.org>
Cc: <viro@zeniv.linux.org.uk>, <djwong@kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <david@fromorbit.com>, <hch@infradead.org>, <jiang.yong5@zte.com.cn>,
        <wang.liang82@zte.com.cn>, <liu.dong3@zte.com.cn>
Subject: =?UTF-8?B?UmU6IFtSRkMgUEFUQ0hdIGZzOiBpbnRyb2R1Y2UgY2hlY2sgZm9yIGRyb3AvaW5jX25saW5r?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 39D9esWV078823
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 652910AE.000/4S6M2Q36gSz4xVbr
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> On Fri, Oct 13, 2023 at 03:27:30PM +0800, cheng.lin130@zte.com.cn wrote:
> > From: Cheng Lin <cheng.lin130@zte.com.cn>
> >
> > Avoid inode nlink overflow or underflow.
> >
> > Signed-off-by: Cheng Lin <cheng.lin130@zte.com.cn>
> > ---
> I'm very confused. There's no explanation why that's needed. As it
> stands it's not possible to provide a useful review.
> I'm not saying it's wrong. I just don't understand why and even if this
> should please show up in the commit message.
In an xfs issue, there was an nlink underflow of a directory inode. There
is a key information in the kernel messages, that is the WARN_ON from
drop_nlink(). However, VFS did not prevent the underflow. I'm not sure
if this behavior is inadvertent or specifically designed. As an abnormal
situation, perhaps prohibiting nlink overflow or underflow is a better way
to handle it.
Request for your comment.

