Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7525649CB3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2019 11:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729199AbfFRJJj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jun 2019 05:09:39 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:16667 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729095AbfFRJJj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jun 2019 05:09:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1560848978; x=1592384978;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Cdg4TJFxFpW/G/zXgdRUlUuTFYoGRU0I/YFoY+ZHhCo=;
  b=TJ+q2TXbHEQuZLqGP/Gbz4XQ0NvfbqDuiMBOt0DFM+ehdNncc5w5zIOy
   yGd1e1W6UlFSYLxNQr56ctPLgLnONu0ZT8w0pVmgMPPA6JIG/jf9+3VJE
   +o2ZEKXivUhgdogZ+VYjSCbb+Qb+bk8QsyYM8d1+Z5k1pZKa8WSDrZ4Dv
   Ss9MvdmaIA1FKt+J6/RP+UaYl4izrWmpRM9/tp+OzbSikM8G+esNrQWSR
   W5X2GGCU5naBDUaIfyKfAXpNA3rcuvAc7YQe7W6MSSqqY/Q3S++3Kdkml
   oN1Cr6b8rQM6lkD7gyU0TASAD90BlTKe0zBsF0wyuSl226ncVLB8DtLW9
   Q==;
X-IronPort-AV: E=Sophos;i="5.63,388,1557158400"; 
   d="scan'208";a="112087022"
Received: from mail-bn3nam01lp2059.outbound.protection.outlook.com (HELO NAM01-BN3-obe.outbound.protection.outlook.com) ([104.47.33.59])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jun 2019 17:09:37 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p8iXbvz5Lk6pFlvxfa6EHkV42Dgdp6Y+oDvRZa8IYvs=;
 b=BHfL1jyd88OrU3c1xGoVDV/okYtWrS3Nz9CWinKelxzni4hoY477U7GSbr1qDNsA/yuqNyTAQGv6tASDgdSZkNWCAahSmqRcLhsMSYrx5LN+xmS8jf/ELgCEiowcvur7Ll4rAHhdriSQE2nsWGKnlgmoKO7xdYYxy8n5/u8aHSA=
Received: from SN6PR04MB5231.namprd04.prod.outlook.com (20.177.254.85) by
 SN6PR04MB5118.namprd04.prod.outlook.com (52.135.116.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Tue, 18 Jun 2019 09:09:34 +0000
Received: from SN6PR04MB5231.namprd04.prod.outlook.com
 ([fe80::5005:99a1:65aa:f088]) by SN6PR04MB5231.namprd04.prod.outlook.com
 ([fe80::5005:99a1:65aa:f088%6]) with mapi id 15.20.1987.013; Tue, 18 Jun 2019
 09:09:34 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Qu Wenruo <wqu@suse.com>, Nikolay Borisov <nborisov@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        =?iso-8859-1?Q?Matias_Bj=F8rling?= <mb@lightnvm.io>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 14/19] btrfs: redirty released extent buffers in
 sequential BGs
Thread-Topic: [PATCH 14/19] btrfs: redirty released extent buffers in
 sequential BGs
Thread-Index: AQHVHTKP/a9sOH6tTEWoQyojzmYTGQ==
Date:   Tue, 18 Jun 2019 09:09:34 +0000
Message-ID: <SN6PR04MB523180783547B7CEC55285968CEA0@SN6PR04MB5231.namprd04.prod.outlook.com>
References: <20190607131025.31996-1-naohiro.aota@wdc.com>
 <20190607131025.31996-15-naohiro.aota@wdc.com>
 <20190613142408.p3ra5urczrzgqr2q@MacBook-Pro-91.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Naohiro.Aota@wdc.com; 
x-originating-ip: [199.255.47.8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c104ad92-f80d-46dc-f8b0-08d6f3ccaea4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR04MB5118;
x-ms-traffictypediagnostic: SN6PR04MB5118:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB511874A77D550FA5E245B7B08CEA0@SN6PR04MB5118.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 007271867D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(136003)(396003)(346002)(366004)(189003)(199004)(305945005)(91956017)(66446008)(66946007)(52536014)(76116006)(66556008)(64756008)(2906002)(66476007)(73956011)(5660300002)(25786009)(6246003)(4326008)(6916009)(6116002)(14454004)(3846002)(478600001)(55016002)(71190400001)(71200400001)(68736007)(9686003)(72206003)(53936002)(6436002)(86362001)(54906003)(316002)(256004)(33656002)(229853002)(8676002)(102836004)(14444005)(76176011)(81166006)(81156014)(66066001)(6506007)(8936002)(446003)(53546011)(7416002)(7696005)(486006)(74316002)(476003)(7736002)(26005)(186003)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB5118;H:SN6PR04MB5231.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dvE6lxM6XoAuJyCxsXGCPuc+OWWV6BSxMLD5OQ0kYoS0hT7BrIufeCApjXH0fZJOJMMNI6AN8A6pFA9iGTNwTZKe1he9InQSI9oAAAwdzybIKY8CUX2LksLAM37OXs22OcyIQAZU1nk+Vr8xSbpokbkeFMB1iVSWk2e9OrLZ/LMhgWr32cMGPM+8Zxpt2GR6d1qJeurm3Pl5tcThTTW/cFYNOkuGUJ5+I8nEr3SrmmCTsNHFjNZt7RyqgWOUcvF2uAhGzgbFRgUNCuVxZtQ5m7VeNxQGLieNeuETqniZJXsQt1lEVgmpqzgty+BAbiLSGijXd2ZPCXyL0o9KZjzLrKC4nwsWg8PUnkufeX6+AY6T0qNhUbnGeVlI7U0Vk9GxusG03jYkAFGFyrKxlg4Eph381Cu3tZCfaiGyr5Egw/Q=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c104ad92-f80d-46dc-f8b0-08d6f3ccaea4
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2019 09:09:34.7469
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Naohiro.Aota1@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5118
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/06/13 23:24, Josef Bacik wrote:=0A=
> On Fri, Jun 07, 2019 at 10:10:20PM +0900, Naohiro Aota wrote:=0A=
>> Tree manipulating operations like merging nodes often release=0A=
>> once-allocated tree nodes. Btrfs cleans such nodes so that pages in the=
=0A=
>> node are not uselessly written out. On HMZONED drives, however, such=0A=
>> optimization blocks the following IOs as the cancellation of the write o=
ut=0A=
>> of the freed blocks breaks the sequential write sequence expected by the=
=0A=
>> device.=0A=
>>=0A=
>> This patch introduces a list of clean extent buffers that have been=0A=
>> released in a transaction. Btrfs consult the list before writing out and=
=0A=
>> waiting for the IOs, and it redirties a buffer if 1) it's in sequential =
BG,=0A=
>> 2) it's in un-submit range, and 3) it's not under IO. Thus, such buffers=
=0A=
>> are marked for IO in btrfs_write_and_wait_transaction() to send proper b=
ios=0A=
>> to the disk.=0A=
>>=0A=
>> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>=0A=
>> ---=0A=
>>   fs/btrfs/disk-io.c     | 27 ++++++++++++++++++++++++---=0A=
>>   fs/btrfs/extent_io.c   |  1 +=0A=
>>   fs/btrfs/extent_io.h   |  2 ++=0A=
>>   fs/btrfs/transaction.c | 35 +++++++++++++++++++++++++++++++++++=0A=
>>   fs/btrfs/transaction.h |  3 +++=0A=
>>   5 files changed, 65 insertions(+), 3 deletions(-)=0A=
>>=0A=
>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c=0A=
>> index 6651986da470..c6147fce648f 100644=0A=
>> --- a/fs/btrfs/disk-io.c=0A=
>> +++ b/fs/btrfs/disk-io.c=0A=
>> @@ -535,7 +535,9 @@ static int csum_dirty_buffer(struct btrfs_fs_info *f=
s_info, struct page *page)=0A=
>>   	if (csum_tree_block(eb, result))=0A=
>>   		return -EINVAL;=0A=
>>   =0A=
>> -	if (btrfs_header_level(eb))=0A=
>> +	if (test_bit(EXTENT_BUFFER_NO_CHECK, &eb->bflags))=0A=
>> +		ret =3D 0;=0A=
>> +	else if (btrfs_header_level(eb))=0A=
>>   		ret =3D btrfs_check_node(eb);=0A=
>>   	else=0A=
>>   		ret =3D btrfs_check_leaf_full(eb);=0A=
>> @@ -1115,10 +1117,20 @@ struct extent_buffer *read_tree_block(struct btr=
fs_fs_info *fs_info, u64 bytenr,=0A=
>>   void btrfs_clean_tree_block(struct extent_buffer *buf)=0A=
>>   {=0A=
>>   	struct btrfs_fs_info *fs_info =3D buf->fs_info;=0A=
>> -	if (btrfs_header_generation(buf) =3D=3D=0A=
>> -	    fs_info->running_transaction->transid) {=0A=
>> +	struct btrfs_transaction *cur_trans =3D fs_info->running_transaction;=
=0A=
>> +=0A=
>> +	if (btrfs_header_generation(buf) =3D=3D cur_trans->transid) {=0A=
>>   		btrfs_assert_tree_locked(buf);=0A=
>>   =0A=
>> +		if (btrfs_fs_incompat(fs_info, HMZONED) &&=0A=
>> +		    list_empty(&buf->release_list)) {=0A=
>> +			atomic_inc(&buf->refs);=0A=
>> +			spin_lock(&cur_trans->releasing_ebs_lock);=0A=
>> +			list_add_tail(&buf->release_list,=0A=
>> +				      &cur_trans->releasing_ebs);=0A=
>> +			spin_unlock(&cur_trans->releasing_ebs_lock);=0A=
>> +		}=0A=
>> +=0A=
>>   		if (test_and_clear_bit(EXTENT_BUFFER_DIRTY, &buf->bflags)) {=0A=
>>   			percpu_counter_add_batch(&fs_info->dirty_metadata_bytes,=0A=
>>   						 -buf->len,=0A=
>> @@ -4533,6 +4545,15 @@ void btrfs_cleanup_one_transaction(struct btrfs_t=
ransaction *cur_trans,=0A=
>>   	btrfs_destroy_pinned_extent(fs_info,=0A=
>>   				    fs_info->pinned_extents);=0A=
>>   =0A=
>> +	while (!list_empty(&cur_trans->releasing_ebs)) {=0A=
>> +		struct extent_buffer *eb;=0A=
>> +=0A=
>> +		eb =3D list_first_entry(&cur_trans->releasing_ebs,=0A=
>> +				      struct extent_buffer, release_list);=0A=
>> +		list_del_init(&eb->release_list);=0A=
>> +		free_extent_buffer(eb);=0A=
>> +	}=0A=
>> +=0A=
>>   	cur_trans->state =3DTRANS_STATE_COMPLETED;=0A=
>>   	wake_up(&cur_trans->commit_wait);=0A=
>>   }=0A=
>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c=0A=
>> index 13fca7bfc1f2..c73c69e2bef4 100644=0A=
>> --- a/fs/btrfs/extent_io.c=0A=
>> +++ b/fs/btrfs/extent_io.c=0A=
>> @@ -4816,6 +4816,7 @@ __alloc_extent_buffer(struct btrfs_fs_info *fs_inf=
o, u64 start,=0A=
>>   	init_waitqueue_head(&eb->read_lock_wq);=0A=
>>   =0A=
>>   	btrfs_leak_debug_add(&eb->leak_list, &buffers);=0A=
>> +	INIT_LIST_HEAD(&eb->release_list);=0A=
>>   =0A=
>>   	spin_lock_init(&eb->refs_lock);=0A=
>>   	atomic_set(&eb->refs, 1);=0A=
>> diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h=0A=
>> index aa18a16a6ed7..2987a01f84f9 100644=0A=
>> --- a/fs/btrfs/extent_io.h=0A=
>> +++ b/fs/btrfs/extent_io.h=0A=
>> @@ -58,6 +58,7 @@ enum {=0A=
>>   	EXTENT_BUFFER_IN_TREE,=0A=
>>   	/* write IO error */=0A=
>>   	EXTENT_BUFFER_WRITE_ERR,=0A=
>> +	EXTENT_BUFFER_NO_CHECK,=0A=
>>   };=0A=
>>   =0A=
>>   /* these are flags for __process_pages_contig */=0A=
>> @@ -186,6 +187,7 @@ struct extent_buffer {=0A=
>>   	 */=0A=
>>   	wait_queue_head_t read_lock_wq;=0A=
>>   	struct page *pages[INLINE_EXTENT_BUFFER_PAGES];=0A=
>> +	struct list_head release_list;=0A=
>>   #ifdef CONFIG_BTRFS_DEBUG=0A=
>>   	atomic_t spinning_writers;=0A=
>>   	atomic_t spinning_readers;=0A=
>> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c=0A=
>> index 3f6811cdf803..ded40ad75419 100644=0A=
>> --- a/fs/btrfs/transaction.c=0A=
>> +++ b/fs/btrfs/transaction.c=0A=
>> @@ -236,6 +236,8 @@ static noinline int join_transaction(struct btrfs_fs=
_info *fs_info,=0A=
>>   	spin_lock_init(&cur_trans->dirty_bgs_lock);=0A=
>>   	INIT_LIST_HEAD(&cur_trans->deleted_bgs);=0A=
>>   	spin_lock_init(&cur_trans->dropped_roots_lock);=0A=
>> +	INIT_LIST_HEAD(&cur_trans->releasing_ebs);=0A=
>> +	spin_lock_init(&cur_trans->releasing_ebs_lock);=0A=
>>   	list_add_tail(&cur_trans->list, &fs_info->trans_list);=0A=
>>   	extent_io_tree_init(fs_info, &cur_trans->dirty_pages,=0A=
>>   			IO_TREE_TRANS_DIRTY_PAGES, fs_info->btree_inode);=0A=
>> @@ -2219,7 +2221,31 @@ int btrfs_commit_transaction(struct btrfs_trans_h=
andle *trans)=0A=
>>   =0A=
>>   	wake_up(&fs_info->transaction_wait);=0A=
>>   =0A=
>> +	if (btrfs_fs_incompat(fs_info, HMZONED)) {=0A=
>> +		struct extent_buffer *eb;=0A=
>> +=0A=
>> +		list_for_each_entry(eb, &cur_trans->releasing_ebs,=0A=
>> +				    release_list) {=0A=
>> +			struct btrfs_block_group_cache *cache;=0A=
>> +=0A=
>> +			cache =3D btrfs_lookup_block_group(fs_info, eb->start);=0A=
>> +			if (!cache)=0A=
>> +				continue;=0A=
>> +			mutex_lock(&cache->submit_lock);=0A=
>> +			if (cache->alloc_type =3D=3D BTRFS_ALLOC_SEQ &&=0A=
>> +			    cache->submit_offset <=3D eb->start &&=0A=
>> +			    !extent_buffer_under_io(eb)) {=0A=
>> +				set_extent_buffer_dirty(eb);=0A=
>> +				cache->space_info->bytes_readonly +=3D eb->len;=0A=
> =0A=
> Huh?=0A=
> =0A=
=0A=
I'm tracking once allocated then freed region in "space_info->bytes_readonl=
y".=0A=
As I wrote in the other reply, I can add and use "space_info->bytes_zone_un=
available" instead.=0A=
=0A=
>> +				set_bit(EXTENT_BUFFER_NO_CHECK, &eb->bflags);=0A=
>> +			}=0A=
>> +			mutex_unlock(&cache->submit_lock);=0A=
>> +			btrfs_put_block_group(cache);=0A=
>> +		}=0A=
>> +	}=0A=
>> +=0A=
> =0A=
> Helper here please.=0A=
>>   	ret =3D btrfs_write_and_wait_transaction(trans);=0A=
>> +=0A=
>>   	if (ret) {=0A=
>>   		btrfs_handle_fs_error(fs_info, ret,=0A=
>>   				      "Error while writing out transaction");=0A=
>> @@ -2227,6 +2253,15 @@ int btrfs_commit_transaction(struct btrfs_trans_h=
andle *trans)=0A=
>>   		goto scrub_continue;=0A=
>>   	}=0A=
>>   =0A=
>> +	while (!list_empty(&cur_trans->releasing_ebs)) {=0A=
>> +		struct extent_buffer *eb;=0A=
>> +=0A=
>> +		eb =3D list_first_entry(&cur_trans->releasing_ebs,=0A=
>> +				      struct extent_buffer, release_list);=0A=
>> +		list_del_init(&eb->release_list);=0A=
>> +		free_extent_buffer(eb);=0A=
>> +	}=0A=
>> +=0A=
> =0A=
> Another helper, and also can't we release eb's above that we didn't need =
to=0A=
> re-mark dirty?  Thanks,=0A=
> =0A=
> Josef=0A=
> =0A=
=0A=
hm, we can do so. I'll change the code in the next version.=0A=
Thanks,=0A=
