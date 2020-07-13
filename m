Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA3E821D14C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jul 2020 10:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729218AbgGMICe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jul 2020 04:02:34 -0400
Received: from mail-eopbgr130105.outbound.protection.outlook.com ([40.107.13.105]:54022
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726077AbgGMICd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jul 2020 04:02:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Omksz3jh7v9RR/IlVX2gPj/KK6CpRGnWaE4px1uWh7tXar9P2O3vhQYpP3jQEp9AyCNa3xAytS3I2GZ49xBbx2xJPRuFDo+XcnBSSj95IeFV9UC1Kr0zJMi6IIyvl74+H80aTV5ZspQipNyEMCuaktCigZj6/ZYgCTwjaBlLx96S2Y39SMPKODAv/4H3FHz4WdexqfMSufezokrGjdwUYu6Vuz0mlGZ8zvBlnIDoTB2D/YSCEgsEsYEhemwGsHxu9hV39AcL55uqmb/84mk5fHN5bRMeeNL3zJWiu4fCj065yWjmR8hSlDq2Zvqxu7E7vXysqzbAFhf8L4Y9ygSG0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=egvfmt5b2zT5HeRgUVQo7GMl3qvWN49mELa4HmgLHXk=;
 b=SB7YcTPeGn/zU2Zzsi87aHLPvwo6iFnJ18xFSj7tQYjeD9l80+9yspkV1HAX33NCQ3p9aYac3CoT83xqNMQbDF6xVUWTNvAcl83Y2M7q28bx547yKnTlZQrZNKhfPMGl0EWgLH58ata7C8+ECUYG7u0oCc5I2rkakNs82fHKY7RO3iRWJQ2zdhE7TE5dcAhhhrapRnKPDek6iISQ27pu6H2W+q6mmkOjeSsfot0ZJ2sy5xOyumTZI3U7Nhz6tD9hpfLS5ge2KpS5j8nFE1aAZAxw7DEM0jzSCzKEYWMSqU3xopQCMS8PEP0oISuxATt930KkriAEPi3akeEsG5Grsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=egvfmt5b2zT5HeRgUVQo7GMl3qvWN49mELa4HmgLHXk=;
 b=ot6lF+gCA/8E7yKjkalQxT6mAEKrNnu/LFhjPH8ggaCpOzDD5M/PpoVsrl6h2AigeGz1WTCSwSHKErjkW38a1I3mQiRCEF5GT5t/azjyPyIW3Y16lmNinbL+kh3MhUy8mOnN5fAKnjXyEUuYyhczTXyDaJDMrQ1jRcczwi/dGI8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from AM0PR08MB5140.eurprd08.prod.outlook.com (2603:10a6:208:162::17)
 by AM0PR08MB3476.eurprd08.prod.outlook.com (2603:10a6:208:dd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Mon, 13 Jul
 2020 08:02:28 +0000
Received: from AM0PR08MB5140.eurprd08.prod.outlook.com
 ([fe80::189d:9569:dbb8:2783]) by AM0PR08MB5140.eurprd08.prod.outlook.com
 ([fe80::189d:9569:dbb8:2783%6]) with mapi id 15.20.3174.025; Mon, 13 Jul 2020
 08:02:28 +0000
Subject: Re: [PATCH] fuse_writepages_fill() optimization to avoid WARN_ON in
 tree_insert
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, Maxim Patlasov <maximvp@gmail.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <2733b41a-b4c6-be94-0118-a1a8d6f26eec@virtuozzo.com>
 <d6e8ef46-c311-b993-909c-4ae2823e2237@virtuozzo.com>
 <CAJfpegupeWA_dFi5Q4RBSdHFAkutEeRk3Z1KZ5mtfkFn-ROo=A@mail.gmail.com>
From:   Vasily Averin <vvs@virtuozzo.com>
Message-ID: <8da94b27-484c-98e4-2152-69d282bcfc50@virtuozzo.com>
Date:   Mon, 13 Jul 2020 11:02:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <CAJfpegupeWA_dFi5Q4RBSdHFAkutEeRk3Z1KZ5mtfkFn-ROo=A@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------7E26CBC7199E0A61D28F886F"
Content-Language: en-US
X-ClientProxiedBy: AM0PR10CA0068.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::21) To AM0PR08MB5140.eurprd08.prod.outlook.com
 (2603:10a6:208:162::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.21] (185.231.240.5) by AM0PR10CA0068.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20 via Frontend Transport; Mon, 13 Jul 2020 08:02:27 +0000
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07fb0231-c89e-499f-f5ad-08d82703160a
X-MS-TrafficTypeDiagnostic: AM0PR08MB3476:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB34762290E40E320E749E6C00AA600@AM0PR08MB3476.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Si74XWFj4rKPBWXVj2X4JNepSI4Zam6nyMvk/Hp0NAQa5rnOMI5xtOaEIJliUXhI/jKAk6oy03i09ns5ugAIcFeEWEYPeIKhm7/2jpGEeAxmytvf5f9riFLbQVKC1kXJmEWUMUSUlaJfhFUXL8QWqMHKAKubw9eyXdZyivuFmN9TAWgn7YkjMHfPaW3vqkf/ci2XzfkfWLQe22Hp9+XoAJjF0Uw2nXSMB5ihmIxbHthSjXy26Lk/mct3usaTaPt4wM8FIQBkkfRV9Z6incynN2EndBCOnPjccr03WTlf67sRNAeOI+g+V0hSdLhabVbmCOEQoCezIjkFEE4SbtscghXmZz3HIDQVXJ4mLoTtc22aFBfzAEkPM8iXh7kOXS6d
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR08MB5140.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39830400003)(376002)(346002)(136003)(366004)(5660300002)(52116002)(31696002)(235185007)(33964004)(316002)(86362001)(186003)(16526019)(2906002)(26005)(53546011)(6916009)(478600001)(36756003)(66476007)(66616009)(66556008)(6486002)(956004)(4326008)(66946007)(2616005)(83380400001)(8936002)(54906003)(16576012)(8676002)(31686004)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: Yzu/Wqtr1ysrxkT2WWsCP3dPt4LiDlVg0e8fgdT+PpJUGXZvcbBIylb/E7k7SUN31ddJ8w61zTjFx+2IhUBSXVWecYzg7UN6+JgULiQ5rakrmZpEgAyQdJ4vL35ZaaOTt7Z0QR1+nW4z77/TzXoPzyxJq7+1kWYq+WS+wcDqeTwPHO4mqfg11n6JFog2DtF6DXlMax8+0HxXdZPf62o9AnE9jf+a+JdR9KYNV5OCpoy4YJ2SbM223ydH8HlKVhieEhwLEAJ42y/gRb1Z7UGCgNTDu+O8oL9MDrgr9DfKDTW/YK0h60S2cLMVz9vS1biR58bd7zk7Y4msBBwdfBwC6/suKw90+n9J+vLl1ARLJB12Ili0p0nKhl5kvV3i4+jRa+Zr2IjlE4+P6lkpMr9pi/YGF68f2I+ESj/RJ4bV7CFiF3B4OSiGRBlEaz096CazN5Sj8wqiHR+G2yUN5GRXnXKRpmthRdMaFKXC3tA7TYU=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07fb0231-c89e-499f-f5ad-08d82703160a
X-MS-Exchange-CrossTenant-AuthSource: AM0PR08MB5140.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2020 08:02:28.3615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +naKdzoNU8yFEPnPSleCfOJADk7C5lq0XweQ6Xh9iWz5peOxPYXb28/G/66Bw8C/3d/Upfn9LxZ2Moc4q7b7ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3476
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--------------7E26CBC7199E0A61D28F886F
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 7/11/20 7:01 AM, Miklos Szeredi wrote:
> On Thu, Jun 25, 2020 at 11:02 AM Vasily Averin <vvs@virtuozzo.com> wrote:
>>
>> In current implementation fuse_writepages_fill() tries to share the code:
>> for new wpa it calls tree_insert() with num_pages = 0
>> then switches to common code used non-modified num_pages
>> and increments it at the very end.
>>
>> Though it triggers WARN_ON(!wpa->ia.ap.num_pages) in tree_insert()
>>  WARNING: CPU: 1 PID: 17211 at fs/fuse/file.c:1728 tree_insert+0xab/0xc0 [fuse]
>>  RIP: 0010:tree_insert+0xab/0xc0 [fuse]
>>  Call Trace:
>>   fuse_writepages_fill+0x5da/0x6a0 [fuse]
>>   write_cache_pages+0x171/0x470
>>   fuse_writepages+0x8a/0x100 [fuse]
>>   do_writepages+0x43/0xe0
>>
>> This patch re-works fuse_writepages_fill() to call tree_insert()
>> with num_pages = 1 and avoids its subsequent increment and
>> an extra spin_lock(&fi->lock) for newly added wpa.
> 
> Looks good.  However, I don't like the way fuse_writepage_in_flight()
> is silently changed to insert page into the rb_tree.  Also the
> insertion can be merged with the search for in-flight and be done
> unconditionally to simplify the logic.  See attached patch.

Your patch looks correct for me except 2 things:
1) you have lost "data->wpa = NULL;" when fuse_writepage_add() returns false.
2) in the same case old code did not set data->orig_pages[ap->num_pages] = page;

I've lightly updated your patch to fix noticed problems, please see attached patch.

Thank you,
	Vasily Averin

--------------7E26CBC7199E0A61D28F886F
Content-Type: text/x-patch; charset=UTF-8;
 name="vvs.fuse-fix-warning-in-tree_insert.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="vvs.fuse-fix-warning-in-tree_insert.patch"

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index e573b0cd2737..57721570c005 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1674,7 +1674,8 @@ __acquires(fi->lock)
 	}
 }
 
-static void tree_insert(struct rb_root *root, struct fuse_writepage_args *wpa)
+static struct fuse_writepage_args *fuse_insert_writeback(struct rb_root *root,
+						struct fuse_writepage_args *wpa)
 {
 	pgoff_t idx_from = wpa->ia.write.in.offset >> PAGE_SHIFT;
 	pgoff_t idx_to = idx_from + wpa->ia.ap.num_pages - 1;
@@ -1697,11 +1698,17 @@ static void tree_insert(struct rb_root *root, struct fuse_writepage_args *wpa)
 		else if (idx_to < curr_index)
 			p = &(*p)->rb_left;
 		else
-			return (void) WARN_ON(true);
+			return curr;
 	}
 
 	rb_link_node(&wpa->writepages_entry, parent, p);
 	rb_insert_color(&wpa->writepages_entry, root);
+	return NULL;
+}
+
+static void tree_insert(struct rb_root *root, struct fuse_writepage_args *wpa)
+{
+	WARN_ON(fuse_insert_writeback(root, wpa));
 }
 
 static void fuse_writepage_end(struct fuse_conn *fc, struct fuse_args *args,
@@ -1952,14 +1959,14 @@ static void fuse_writepages_send(struct fuse_fill_wb_data *data)
 }
 
 /*
- * First recheck under fi->lock if the offending offset is still under
- * writeback.  If yes, then iterate auxiliary write requests, to see if there's
+ * Check under fi->lock if the page is under writeback, and insert it onto the
+ * rb_tree if not. Otherwise iterate auxiliary write requests, to see if there's
  * one already added for a page at this offset.  If there's none, then insert
  * this new request onto the auxiliary list, otherwise reuse the existing one by
- * copying the new page contents over to the old temporary page.
+ * swapping the new temp page with the old one.
  */
-static bool fuse_writepage_in_flight(struct fuse_writepage_args *new_wpa,
-				     struct page *page)
+static bool fuse_writepage_add(struct fuse_writepage_args *new_wpa,
+			       struct page *page)
 {
 	struct fuse_inode *fi = get_fuse_inode(new_wpa->inode);
 	struct fuse_writepage_args *tmp;
@@ -1967,17 +1974,15 @@ static bool fuse_writepage_in_flight(struct fuse_writepage_args *new_wpa,
 	struct fuse_args_pages *new_ap = &new_wpa->ia.ap;
 
 	WARN_ON(new_ap->num_pages != 0);
+	new_ap->num_pages = 1;
 
 	spin_lock(&fi->lock);
-	rb_erase(&new_wpa->writepages_entry, &fi->writepages);
-	old_wpa = fuse_find_writeback(fi, page->index, page->index);
+	old_wpa = fuse_insert_writeback(&fi->writepages, new_wpa);
 	if (!old_wpa) {
-		tree_insert(&fi->writepages, new_wpa);
 		spin_unlock(&fi->lock);
-		return false;
+		return true;
 	}
 
-	new_ap->num_pages = 1;
 	for (tmp = old_wpa->next; tmp; tmp = tmp->next) {
 		pgoff_t curr_index;
 
@@ -2006,7 +2011,7 @@ static bool fuse_writepage_in_flight(struct fuse_writepage_args *new_wpa,
 		fuse_writepage_free(new_wpa);
 	}
 
-	return true;
+	return false;
 }
 
 static int fuse_writepages_fill(struct page *page,
@@ -2085,12 +2090,6 @@ static int fuse_writepages_fill(struct page *page,
 		ap->args.end = fuse_writepage_end;
 		ap->num_pages = 0;
 		wpa->inode = inode;
-
-		spin_lock(&fi->lock);
-		tree_insert(&fi->writepages, wpa);
-		spin_unlock(&fi->lock);
-
-		data->wpa = wpa;
 	}
 	set_page_writeback(page);
 
@@ -2103,20 +2102,22 @@ static int fuse_writepages_fill(struct page *page,
 	inc_node_page_state(tmp_page, NR_WRITEBACK_TEMP);
 
 	err = 0;
-	if (is_writeback && fuse_writepage_in_flight(wpa, page)) {
+	if (data->wpa) {
+		/*
+		 * Protected by fi->lock against concurrent access by
+		 * fuse_page_is_writeback().
+		 */
+		spin_lock(&fi->lock);
+		ap->num_pages++;
+		spin_unlock(&fi->lock);
+	} else if (fuse_writepage_add(wpa, page)) {
+		data->wpa = wpa;
+	} else {
 		end_page_writeback(page);
 		data->wpa = NULL;
 		goto out_unlock;
 	}
-	data->orig_pages[ap->num_pages] = page;
-
-	/*
-	 * Protected by fi->lock against concurrent access by
-	 * fuse_page_is_writeback().
-	 */
-	spin_lock(&fi->lock);
-	ap->num_pages++;
-	spin_unlock(&fi->lock);
+	data->orig_pages[ap->num_pages-1] = page;
 
 out_unlock:
 	unlock_page(page);

--------------7E26CBC7199E0A61D28F886F--
