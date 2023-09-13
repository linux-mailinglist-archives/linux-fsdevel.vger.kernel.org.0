Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDC7F79E89F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Sep 2023 15:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240773AbjIMNHZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Sep 2023 09:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240733AbjIMNHV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Sep 2023 09:07:21 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2135.outbound.protection.outlook.com [40.107.255.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7181BE9;
        Wed, 13 Sep 2023 06:07:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XTm4eAbQP5p+spsqqgEEjn8uL+cW4O1BOWcYeh4DHuB65GZbWzN5MGfDWiuM0Xlgz35sWNf/uJkfBNh6ju1J7lS+5iu7TqzYcusgCpanwrky+wcjd31TOlnOguQtqCs5YA36KxLxV11dOYrFUWRAUZnjfy6q6yonOEacHF/0RJHDdIz+eWe19SL1+Nph+ViOzqPgJwa2vdiP3aQCHi9YGkcHjSGy9MoqEdE5j6MI/67q5VdoypbcSixhyCM2JkwdTOQavTvViLOcEZzkB9r9zE5WwaUmzhhrWJgHt8FKJVpib4rKwm/vByzj0/MtaDpYKQtWm4cRnDrzrOnfgcF2wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=da6UkFhcUZtN0di/RgUj8uUwhO2IYDTpM6amaUM13Ts=;
 b=jsHLbHxw1JF9Y9aaC4VrfjJKKnZf+Kfp1E65VyyPN986g18JiyACXSb6mhmndQafGX/AT1ex/QJcxOapt68VMIFYPKB/5UUgUQ2UxU0Som1L4GVbH54D862W1sAYUUncFiwpr4shOoPo+6tZzHUdFu2leAS2bChk1VNbP168vzBPkDyFdAvVkghDhXNFKFjm+oq6Z6krv6/ay6iuunDbXq6ZgP92lCxOV5q4EeKowcVZfDhwznEjhQ6JNlGcHplxCO8ZA+ZNsp0KBxHgab9R9PgmON5QW33GLgyv+9wBQsgAu/jqX4CTRAqw7lGLLcrFndOkGGmOtr8z8+Dx++u8TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=da6UkFhcUZtN0di/RgUj8uUwhO2IYDTpM6amaUM13Ts=;
 b=ejkTaPAXPMCXp5OkBpxWrblTR1bkwS7hqKrlKmk0AGNJOrAUMWEbeoDTCug+l1Js9xczoVGSXKRitEE6cGvQEhonpr0g0PoLpHUz/ftoSGVn2Djv1AfepPLc4zlHOeCsO7LmITRXk0eLxyiVWCwcI1TMPrA8ad3CAGtHpk1XsnGcy0Fc4Xil/ecTwbGI5/O/40rEm9w5F4H/2rmOzdqnMVwfqPXJAjSLMREoFrqjwMXPnzzbApaUQseMn14qAH62yrcmA5ApCrQQyK6GMWe4qjH21ArVS15JjQuZ9iR0VNqo5m2476x+NVwXALzNvNQz+QyaxLhdqhrG2CxPavhKDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TY2PR06MB3342.apcprd06.prod.outlook.com (2603:1096:404:fb::23)
 by SEYPR06MB6455.apcprd06.prod.outlook.com (2603:1096:101:166::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Wed, 13 Sep
 2023 13:07:10 +0000
Received: from TY2PR06MB3342.apcprd06.prod.outlook.com
 ([fe80::60d3:1ef9:d644:3959]) by TY2PR06MB3342.apcprd06.prod.outlook.com
 ([fe80::60d3:1ef9:d644:3959%4]) with mapi id 15.20.6792.019; Wed, 13 Sep 2023
 13:07:10 +0000
From:   Chunhai Guo <guochunhai@vivo.com>
To:     jack@suse.cz, chao@kernel.org, jaegeuk@kernel.org
Cc:     brauner@kernel.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs-writeback: writeback_sb_inodes: Do not increase 'total_wrote' when nothing is written
Date:   Wed, 13 Sep 2023 07:15:01 -0600
Message-Id: <20230913131501.478516-1-guochunhai@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0275.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::17) To TY2PR06MB3342.apcprd06.prod.outlook.com
 (2603:1096:404:fb::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PR06MB3342:EE_|SEYPR06MB6455:EE_
X-MS-Office365-Filtering-Correlation-Id: f8a2b480-c88d-4f39-6b3c-08dbb45a5725
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xO8gebk0tn7ykmpoQrnnxG61z9XXG1GYXP/+jqWYn1LpbqxrlOkq7p38LBuCkPsLXd1bYfT1hgB2miJEK4xRnqOSHWTL8gXrrZubWySTR3j5tqoD0oFsg0gYhR+BK2ge2gHTPRn2S5WFDrKncDeIJbxVZ7mmP/mBsW0ZKKHuLzdccucRrmczpkIX8+j2svB+O1IuvnyiViPR7axVq3+GoiiVwJhFPQhOQXao76S4O5mr1K4q+vEEfT+tniziKuXUppcTsFVQaE5tr22mteaIzyxrqgWdR1kHxgeatYbC0pMGQjl+MNRooWIBdYby8Gi6X4SF7A0RUjN0+wfuBRFSlmpwv8Z2F344Y1Qc6M5My27q0tt7ngjCKpfsFRU6Nkt0vDen5ZpbsNSw0GJ7cwI+79eOoC3nP815L/JQoTAdP03ayfaO42rKvuR85FW7ICjVhU5hcI3eKvRPVwf9pOcc5qFy7Rrsyh9r6TCC/rCFnl1k8/tdao3jmh+Th39PPKEH4Jx1Z/87Y7xxA3i4tWDcx1JR8Tcucnj3VaXrrtLNI16hip+mss93XO6RQEZj0mYaNGYre90Y0o7f8iyiho6Winfdk3bc9RA4gM+ZE0GyLkunR4rCp/4akr/DnBOpDxOS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR06MB3342.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(366004)(396003)(136003)(186009)(451199024)(1800799009)(83380400001)(6666004)(26005)(38350700002)(478600001)(6486002)(6506007)(52116002)(36756003)(38100700002)(1076003)(66476007)(66556008)(66946007)(6512007)(41300700001)(2616005)(316002)(8676002)(8936002)(4326008)(2906002)(5660300002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3CuDhN7P6JKARB7v2s1B2ien0qNbj/4UOT1BiMsieGtlSz6CrOA25bVxKfFB?=
 =?us-ascii?Q?fa2ziRX0AUAFYtPFQrHS+q4mBxb0fOuefdMVw0GVaVeuYXFTFzAblNT6Pr5Q?=
 =?us-ascii?Q?71XGf2V+imLXzCo9o24EI/0ydnn5/uckv0Xpv6Vegttr6frUT6xLRxMXzjrz?=
 =?us-ascii?Q?iCcF3+Uq21OT14Nc6pnFnXeIu1VM4lPbaHmcaeRY/PuUS8s54OfZlJsGUGCJ?=
 =?us-ascii?Q?wZ7OlPo0z5tzPg7uijmVkO90PMtcrpABkaFQCbv68FtFfV5HslItH3sqUf9B?=
 =?us-ascii?Q?fhtWGUsidkE7on15PV+ZOMdUcUd26UPdg3qqu78QkOU3jlqu9r+7GEblYzw8?=
 =?us-ascii?Q?QL62fhf9ZBK4a294rwL47Fnn1YpINsYohXp1bPfHxz+Y1ue1zFy5n7cUgFyz?=
 =?us-ascii?Q?XjUTOxfGMD2iSn4SCt2IaXYF0jXQNzMkpUUGWu7/m+ZboHHRING/YhQnBVl/?=
 =?us-ascii?Q?S069tKl9z39AVzuN1swC/S6ftzTyP+LCsu+zOy4WNNL/mtmQfWxQgmxZHMrg?=
 =?us-ascii?Q?l/3vywertcBoFt8gk3QKjA6tcCMtx2PkTabi+hnOljEdjHrQA/JFxda+Vr3B?=
 =?us-ascii?Q?XR5825ZuiChatid+dm8QxZVENDLScLbufnum/VRytkk9mu2VW1N38j2VuXF5?=
 =?us-ascii?Q?RIxnXrwXCuZJO7Z+JqGnqFCdnogkzac+eqkfP9sea5NC8wuTN26LFCbOy+zw?=
 =?us-ascii?Q?O2z9bo8h7MaDerjRIYu4hLJ2XvTwH37CZ6WVLJZsMjr764aHf+mosR3mnF1O?=
 =?us-ascii?Q?WOBhbaC0YiekXYJhqzZCkG2pirxI/t/i67/PILQUyLvBsmPK5F1y9FrLXF0e?=
 =?us-ascii?Q?W4U8OZ1yGl2fyH2WfEr8/55wnr4J0zYGMyobtH6DuPTxYqkAJdmohx/bBQGy?=
 =?us-ascii?Q?34jZBddb4hsmTXwG4+nlk7E+feQq48qjfuCrgxfL1P7t1Zd/JJ0b+yBcap83?=
 =?us-ascii?Q?4d9ff9aObCvNSJeCAxf58pfOd8/7NCKeLnNRNm2+LlJAyXDUSU/AVdv/C6mo?=
 =?us-ascii?Q?RmNoNOJwwJ4+6k0s7GVYyevuFL2vD6KaUQCNxFVaMmu3a+Mw4jdkcfxcreEL?=
 =?us-ascii?Q?2GrRLWUvkau2ABchksMtF9ShuYz9WN8qZ/Os7E0mBtZaNl8wOfEj8v5L77QT?=
 =?us-ascii?Q?2N6h6CJxwIoRkFghNV28pqBL8/Cjm/R2B/A0gwL/S6v9ny7WE4h6QU3QG1jO?=
 =?us-ascii?Q?7VxI2BjhxDKKrb8SSHxD/j8dNz4jIXlX+gseXbVRcKkO+aR37mv+gsp9p5Hk?=
 =?us-ascii?Q?EXRWLa9hI3Iid38WhjPwVGuOiNqAbxaOI+fSInRNRBvYc41t0mXbhcyGqLhq?=
 =?us-ascii?Q?eQBc3CSlSzaxYFtuOUYDVlMi5lpdAVsUusq6gq7jkKxtDpgs1TEoYJS3H9Io?=
 =?us-ascii?Q?YaKjc3ORj/hIa1ffB56Moqbje63ambvTfMj77Ajr3TFrgZwZminsTdoNSHdJ?=
 =?us-ascii?Q?Ib05el/lh1gjH1yH6/tm3UTn/vh8I6xuMpfcG36/HVkaarYBxDagwdPHp52R?=
 =?us-ascii?Q?J800EZauw/1IkW7zeHgpcPV/cCncxfdn7ivseS7q3++htcKaTnFNQisoJdBq?=
 =?us-ascii?Q?sgEpu7PYRcK1nYs9Pvm+nKkUgAqdthfTY/3ryCIz?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8a2b480-c88d-4f39-6b3c-08dbb45a5725
X-MS-Exchange-CrossTenant-AuthSource: TY2PR06MB3342.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 13:07:10.7306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RiTGCzTZhG0yAnu9DSJ6M8J1cZ5uY1LY013l6bxIYs8iS5roHFrYhUxL7hPSGxd9BCvcCPMUwJrxz84PJXBYvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6455
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> On Wed 13-09-23 10:42:21, Christian Brauner wrote:
> > [+Cc Jan]
> 
> Thanks!
> 
> > On Tue, Sep 12, 2023 at 08:20:43AM -0600, Chunhai Guo wrote:
> > > I am encountering a deadlock issue as shown below. There is a commit 
> > > 344150999b7f ("f2fs: fix to avoid potential deadlock") can fix this
> > > issue.
> > > However, from log analysis, it appears that this is more likely a 
> > > fake progress issue similar to commit 68f4c6eba70d ("fs-writeback:
> > > writeback_sb_inodes: Recalculate 'wrote' according skipped pages"). 
> > > In each writeback iteration, nothing is written, while 
> > > writeback_sb_inodes() increases 'total_wrote' each time, causing an 
> > > infinite loop. This patch fixes this issue by not increasing
> > > 'total_wrote' when nothing is written.
> > >
> > >     wb_writeback        fsync (inode-Y)
> > > blk_start_plug(&plug)
> > > for (;;) {
> > >   iter i-1: some reqs with page-X added into plug->mq_list // f2fs node
> > >   page-X with PG_writeback
> > >                         filemap_fdatawrite
> > >                           __filemap_fdatawrite_range // write inode-Y
> > >                           with sync_mode WB_SYNC_ALL
> > >                            do_writepages
> > >                             f2fs_write_data_pages
> > >                              __f2fs_write_data_pages //
> > >                              wb_sync_req[DATA]++ for WB_SYNC_ALL
> > >                               f2fs_write_cache_pages
> > >                                f2fs_write_single_data_page
> > >                                 f2fs_do_write_data_page
> > >                                  f2fs_outplace_write_data
> > >                                   f2fs_update_data_blkaddr
> > >                                    f2fs_wait_on_page_writeback
> > >                                      wait_on_page_writeback // wait for
> > >                                      f2fs node page-X
> > >   iter i:
> > >     progress = __writeback_inodes_wb(wb, work)
> > >     . writeback_sb_inodes
> > >     .   __writeback_single_inode // write inode-Y with sync_mode
> > >     WB_SYNC_NONE
> > >     .   . do_writepages
> > >     .   .   f2fs_write_data_pages
> > >     .   .   .  __f2fs_write_data_pages // skip writepages due to
> > >     (wb_sync_req[DATA]>0)
> > >     .   .   .   wbc->pages_skipped += get_dirty_pages(inode) //
> > >     wbc->pages_skipped = 1
> > >     .   if (!(inode->i_state & I_DIRTY_ALL)) // i_state = I_SYNC |
> > >     I_SYNC_QUEUED
> > >     .    total_wrote++;  // total_wrote = 1
> > >     .   requeue_inode // requeue inode-Y to wb->b_dirty queue due to
> > >     non-zero pages_skipped
> > >     if (progress) // progress = 1
> > >       continue;
> > >   iter i+1:
> > >       queue_io
> > >       // similar process with iter i, infinite for-loop !
> > > }
> > > blk_finish_plug(&plug)   // flush plug won't be called
> > >
> > > Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
> 
> Thanks for the patch but did you test this patch fixed your deadlock?
> Because the patch seems like a noop to me. Look:

Yes. I have tested this patch and it indeed fixed this deadlock issue, too.

> 
> > > diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c index 
> > > 969ce991b0b0..54cdee906be9 100644
> > > --- a/fs/fs-writeback.c
> > > +++ b/fs/fs-writeback.c
> > > @@ -1820,6 +1820,7 @@ static long writeback_sb_inodes(struct
> > > super_block *sb,
> > >             struct inode *inode = wb_inode(wb->b_io.prev);
> > >             struct bdi_writeback *tmp_wb;
> > >             long wrote;
> > > +           bool is_dirty_before;
> > >
> > >             if (inode->i_sb != sb) {
> > >                     if (work->sb) {
> > > @@ -1881,6 +1882,7 @@ static long writeback_sb_inodes(struct
> > > super_block *sb,
> > >                     continue;
> > >             }
> > >             inode->i_state |= I_SYNC;
> > > +           is_dirty_before = inode->i_state & I_DIRTY_ALL;
> 
> is_dirty_before is going to be set if there's anything dirty - inode, page,
> timestamp. So it can be unset only if there are no dirty pages, in which
> case there are no pages that can be skipped during page writeback, which
> means that requeue_inode() will go and remove inode from b_io/b_dirty lists
> and it will not participate in writeback anymore.
> 
> So I don't see how this patch can be helping anything... Please correct me
> if I'm missing anything.
>                                                                 Honza

From the dump info, there are only two pages as shown below. One is updated
and another is under writeback. Maybe f2fs counts the writeback page as a
dirty one, so get_dirty_pages() got one. As you said, maybe this is
unreasonable.

Jaegeuk & Chao, what do you think of this?


crash_32> files -p 0xE5A44678
 INODE    NRPAGES
e5a44678        2

  PAGE    PHYSICAL   MAPPING    INDEX CNT FLAGS
e8d0e338  641de000  e5a44810         0  5 a095 locked,waiters,uptodate,lru,private,writeback
e8ad59a0  54528000  e5a44810         1  2 2036 referenced,uptodate,lru,active,private

Thanks,

> 
> 
> > >             wbc_attach_and_unlock_inode(&wbc, inode);
> > >
> > >             write_chunk = writeback_chunk_size(wb, work); @@ -1918,7 
> > > +1920,7 @@ static long writeback_sb_inodes(struct super_block *sb,
> > >              */
> > >             tmp_wb = inode_to_wb_and_lock_list(inode);
> > >             spin_lock(&inode->i_lock);
> > > -           if (!(inode->i_state & I_DIRTY_ALL))
> > > +           if (!(inode->i_state & I_DIRTY_ALL) && is_dirty_before)
> > >                     total_wrote++;
> > >             requeue_inode(inode, tmp_wb, &wbc);
> > >             inode_sync_complete(inode);
> > > --
> > > 2.25.1
> > >
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

