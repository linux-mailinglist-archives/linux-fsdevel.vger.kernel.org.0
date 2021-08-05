Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3123E1368
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Aug 2021 13:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240724AbhHELDy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Aug 2021 07:03:54 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:31284 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240722AbhHELDx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Aug 2021 07:03:53 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 175AxH7x017794;
        Thu, 5 Aug 2021 11:02:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=6SWqxwbuwTMB3Mf1Z0xQgcJXfGx3wb5Do+D4K5TAWeY=;
 b=fYklDTRiCm8De9E9Y/+cw1Of863rK82UZEUuXpQIdDhntSIAB/Qd6iRvfMdD+8j7JGXu
 BWWd3jDFEuYnB3u6uqT8iMtefgJWfRQtN5mLGeNFl1eX+bqAS/2uOHQKX80r+CH4I+sE
 9HEblB6I7N4fr5bSZzOSThZIGSp5tLE9qrYK6d14T22WlqkBNQMsCr+KvsSybfpH/DAE
 Oe5Qpflm1rfVCGaOX74CKS5Z0t9zBCXs9JkqZ0sRn6dWk8lSVBm4Titcr8e3uaezQA5b
 pJzA5KXV3yzHV6SD1D52hoC0VklSsYpCSRPZ12P0fpBjoHyn7/aHT/UqMaQJYmP9cyY/ ZQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=6SWqxwbuwTMB3Mf1Z0xQgcJXfGx3wb5Do+D4K5TAWeY=;
 b=xxBAFM0fztCtdL1Ty9YuTypJFvmyq02zaCyYHMI2JrFRqU9mN2X/I6DF/fqrLOH8b2No
 f6hKPM9+3Bb8wqdnOHRWS27zVh+sxVkzGKGdNcgnhnlxJWOotvc8Uj9o2uKxmfh2/0n1
 StWBfliYOrXIaTL9H9zWzgS7Hs76BZzCd86uot/lXfiMcwJm97rKxVWmwXF1w3r0XP+y
 kHaZPy35ROrhxNo/21ya1jMm1oCeFv1bt7Hqj4O830J4bZwGUcUSm/CPMuKPxbeN/cVS
 7rI+L6tqlAah95hI946CtJ6EWj8rRugDt98+U022pyu8y9viw6l7xLHv8bfZFwfHoAHL Ew== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a843p93qx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Aug 2021 11:02:52 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 175AtUje143202;
        Thu, 5 Aug 2021 11:02:51 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by userp3020.oracle.com with ESMTP id 3a5ga00e91-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Aug 2021 11:02:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c02UzhgBRYogfRZXc6Nau2jL9B8jnjIS4f9S7WKOyyTNuVIVca9fqpR+mbezj4sb4iMqCAiuItlcbvnv2QDwJcn6lz7pkcxpX9qKsxIhMG/9frT78hx59oPr7ar8UVLnaBNQLdWpr/Q+ZtG7beCvPJrIXRe12D915XCMfwK7E93mf9pJcTAFXp9DUNTbYoqF7dHa2gAqTY9mVESQFkAb7nI0DYHM3vVsaa5L8/hKOJuBOrExrm0R2cU9Q6HAnIG8aAqP04gFpevX+aCyo+JJSMQhgJ+wNJ7/q9v6l8BgwvvJTHTbhXFb8pMzRYk2MRspVtU9+l0fMNDn4YdFNdk5ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6SWqxwbuwTMB3Mf1Z0xQgcJXfGx3wb5Do+D4K5TAWeY=;
 b=KsJN8eojaoo8SPWoCOEnMUc3BQZttiqmhgPzjupnhvsdihbWP5CaooiBY8a4mtvqyjH3RKwTT6qKDblJQEMTFGbxfJwM/2JAmFMrRekE4bQU9WlMJq56Pf35XaRs5g1yelWDrPTR9QoSimKIi7XDzzLDH7LQYaz/sZui+FHIa3QlhlhQJXa/3lZMPQyZFmHuG+VKdZYau/zx/+WoxXx5kPAlk447iiMz4FjPUyIEwC3vzQlWYT+wRz+Ei9Gdij/Qha+GKwsS7uSrcoI5JoeeBkriJ7ydBD5FHDnFRMdlxWZuJnXNiiCkEhQS3oNXzC+4sAfzTbXdN9w39tSQob2qOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6SWqxwbuwTMB3Mf1Z0xQgcJXfGx3wb5Do+D4K5TAWeY=;
 b=ID5NAOnYCMN8u5v5G4+YHXWFtDhUniICHP5VTDPTICu32hr/q7Ot9USfpQPyiQtM4TcumE0VlSC54CQSwlnMcwoJc7bxpL3PC8161crKXPGk/UsN6F7EWv+aBmP+s6TseV3HQSFVA9RJQN4WrYoGsbEpdfiLV29OGofcy4WViH8=
Authentication-Results: samsung.com; dkim=none (message not signed)
 header.d=none;samsung.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2253.namprd10.prod.outlook.com
 (2603:10b6:301:30::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Thu, 5 Aug
 2021 11:02:46 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4373.027; Thu, 5 Aug 2021
 11:02:46 +0000
Date:   Thu, 5 Aug 2021 14:02:20 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-cifs@vger.kernel.org,
        linux-cifsd-devel@lists.sourceforge.net, aurelien.aptel@gmail.com,
        sandeen@sandeen.net, willy@infradead.org, hch@infradead.org,
        senozhatsky@chromium.org, christian@brauner.io,
        viro@zeniv.linux.org.uk, ronniesahlberg@gmail.com, hch@lst.de,
        metze@samba.org, smfrench@gmail.com, hyc.lee@gmail.com,
        Steve French <stfrench@microsoft.com>
Subject: Re: [PATCH v7 08/13] ksmbd: add smb3 engine part 1
Message-ID: <20210805110219.GJ22532@kadam>
References: <20210805060546.3268-1-namjae.jeon@samsung.com>
 <CGME20210805061600epcas1p13ca76c1e21f317f9f3f52860a70a241e@epcas1p1.samsung.com>
 <20210805060546.3268-9-namjae.jeon@samsung.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210805060546.3268-9-namjae.jeon@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0008.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::20)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (102.222.70.252) by JNXP275CA0008.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Thu, 5 Aug 2021 11:02:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6a2fd3df-be5e-48e6-721c-08d958008e42
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2253:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB22535FD315B5E8CF588B14B88EF29@MWHPR1001MB2253.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4FHLtesMz18tM+jETaFRAYrr3q7FLrxxtoiDC9frhZYJaQFHc+JMfewBBBa4jZUx4IpHzu+hhEOKmbW6klkY3B6fl6BkDQRZ8ov93hyMFXNn5Pkw4Hq4neAKaVcMgeTNbXh++yJ7J9psjLqJYI8D4cQUk2xXmYrGEaNct5CQFD/Vybcu45Fa7JCw987yC232BhhE244ewIMPE4UbzGQ0Kd0G209I1pma5ON+m1vPT/08cMtU9zhyqhjcM6fKRvEOWGqGmn8jYBMJGH55NxuAWmImOtBHa7KMeChRZsJH9ingrE+qS1I2RPUZc1pezoq365kQDdpNf8E3oC3ZdXvjmeP5pC8961j/P/ClxvDJfknSqJ+0VwCptK5Ti47CYCYKeHHH7CYjS6vbdfPxK+vh3Er8ISnvzND7RCVSxZcVwMsTzUOrejuC3x03zVfmr6J8tOe8WQLa8k5zkafC6nXPv/D2X0Y5Go3sFhX+QEA99vgzTxD1cfUypF+62glpJWiCjYXS4GoxReOU0REhyV7KAO0rQooGd41pIFMUpFabvRBAh/PktlVyuMVwLtyeoecIjgvWYAH0CKKIdZI99pZDtByNm0eFGr2L0s9JGaoXcjTAXuFABbeAPDlJzmNnh7UW9Z9fSjw+AHTHxiQ02YqdWVfiEzwmiRrz8VxRfwFlmB2jokWtQOJT0/414FqjGLOP4lHCWxLA24K2nxGidOmL5Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(136003)(346002)(376002)(39860400002)(86362001)(8676002)(9576002)(8936002)(478600001)(66556008)(66946007)(66476007)(6666004)(44832011)(956004)(55016002)(83380400001)(1076003)(5660300002)(9686003)(33656002)(26005)(33716001)(6916009)(7416002)(186003)(4326008)(52116002)(2906002)(38350700002)(38100700002)(6496006)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8oQjri+odvpbJA6g9bF1+VaUz/D6dJEaX4ng0WIEFHJwxdTXuBz7nGzWUvwy?=
 =?us-ascii?Q?JyVCHmu13zbbYI6n2DmenROqyrDvlX+o/JMX8rENkMPuw1HDUdLMJZQqthAr?=
 =?us-ascii?Q?OnkPvQktpAu3sYZ/LxuApLXM+D+YZOACdcOeU9LB89YYbhSSa01ngI+OarCM?=
 =?us-ascii?Q?oYrt+VL8osKgToK1bkZz9DFFFi6kIe+uaAFsK9HcMX4zdN0in2bGTitsVY5/?=
 =?us-ascii?Q?nJbo8XtzQ7fGDarJB7kC46EjPAFhVsuGs5v1/NH/qIKWGR8/LbdRa4VKVP70?=
 =?us-ascii?Q?JalJR9XBi4huXiF6gSm61gEe95LJU0AZ8d1W5oC6sBoWu7tKMcvJDlAcNgpT?=
 =?us-ascii?Q?m3U3iHX4HXw00AQWc4uK3QLF4KVRoPHFLoG0+TRK9G8rKciQKOKkQbWcu3FR?=
 =?us-ascii?Q?GKXzJSRK06okcpfAIMVAzh12KHXmYFsJGKsvT7KWjmIgzKx0sTjEQX83Od40?=
 =?us-ascii?Q?awCfPnVnl7pSHfDHJ3aRHbdn5nGmzkFkkH0XNZO1XGALgY66R/n2pANBxyAR?=
 =?us-ascii?Q?N7K7jXSWMf6ywHzXHG5bBro9DNraj1MnBb2rRvxeYF8EJ/GOLwQno25oElfT?=
 =?us-ascii?Q?4qg3vVOL2lkUYwk5s+7+H+E1aKP8NJwPTilnjw3KbzueMkcgYSDo4tvFvBuO?=
 =?us-ascii?Q?rz5KasDwgVSN5a/rs6Ad1ieBn/o10uCjEgEPRfXjx60Ki62YleBym9sUToeO?=
 =?us-ascii?Q?Giqal1bHsmQBe8KZqvhegfoa8xoh3n3WSLMgOemzme6qkP58HpxZh0kWGKIX?=
 =?us-ascii?Q?SN+bwiwCGcQ8vcSQXrt00BJgdphYUT4wxHyd2t9DgEGlPk09wlYvap+dhOZd?=
 =?us-ascii?Q?2r2HiV6A3NH/x2s59AiPoJ+493sGaHAyp0v8/hkjkNOIL3ySrYubXmUgkj2o?=
 =?us-ascii?Q?yLE21rxUEzyX5mp/dWJdxtEft+gHrnYBTF5/TElLV6TdB0pEyuMKnma/2v6j?=
 =?us-ascii?Q?ECqprpB/urudjw2gncFj8QArrdzwEZC/pkqpiEMCmv4OC89XOsXmJZDIBoL+?=
 =?us-ascii?Q?hlYpwbM/nKBZI/ANI0l+vIxFbn1/Eg82BQWK4UEE2xJCiBzkPsBz83hlUjMl?=
 =?us-ascii?Q?xcEEtsrQ3b37GRRqDiTx3GkOkeM9u4Em1d06bQh0BMAU1q+QmMPQ1jxPwzGs?=
 =?us-ascii?Q?wOxTj/AoSIdBWyHfHdrePrzUHv2tvc8E4/yAdkGZzTyiNnQEHd+Ee2li5ZIH?=
 =?us-ascii?Q?S05Bp3qeH6y499haRsH3g7Y78Z+VZ6uCfEbMnEa02UVsOmWOjpCJSc9Q8Mkq?=
 =?us-ascii?Q?L/t/3cXWbLUtB7EiQOJCF9VG/LIhn7fZmPp+uA4C6seuTqtxtrCCfNbxyods?=
 =?us-ascii?Q?6/90lE9chNjXw6g9Wy4rW4LH?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a2fd3df-be5e-48e6-721c-08d958008e42
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2021 11:02:46.5945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PpxzraJFMLDhbximNAjVA8oVoNQsFCerWQM/fSgdjf1ZfFE22u7BKpP7pWg2719VU05VFj8AspxxkVD5UH6zsyihVqdVzrLogDsFrvlcQUM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2253
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10066 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108050066
X-Proofpoint-ORIG-GUID: zwoY1dxW6NisIiCxYS3hO_3k42UQauJA
X-Proofpoint-GUID: zwoY1dxW6NisIiCxYS3hO_3k42UQauJA
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 05, 2021 at 03:05:41PM +0900, Namjae Jeon wrote:
> +/**
> + * check_session_id() - check for valid session id in smb header
> + * @conn:	connection instance
> + * @id:		session id from smb header
> + *
> + * Return:      1 if valid session id, otherwise 0
> + */
> +static inline int check_session_id(struct ksmbd_conn *conn, u64 id)

Make this bool.  Same for all the is_* functions.

> +{
> +	struct ksmbd_session *sess;
> +
> +	if (id == 0 || id == -1)
> +		return 0;
> +
> +	sess = ksmbd_session_lookup_all(conn, id);
> +	if (sess)
> +		return 1;
> +	pr_err("Invalid user session id: %llu\n", id);
> +	return 0;
> +}
> +
> +struct channel *lookup_chann_list(struct ksmbd_session *sess, struct ksmbd_conn *conn)
> +{
> +	struct channel *chann;
> +
> +	list_for_each_entry(chann, &sess->ksmbd_chann_list, chann_list) {
> +		if (chann->conn == conn)
> +			return chann;
> +	}
> +
> +	return NULL;
> +}
> +
> +/**
> + * smb2_get_ksmbd_tcon() - get tree connection information for a tree id
> + * @work:	smb work
> + *
> + * Return:      matching tree connection on success, otherwise error

This documentation seems out of date.

> + */
> +int smb2_get_ksmbd_tcon(struct ksmbd_work *work)
> +{
> +	struct smb2_hdr *req_hdr = work->request_buf;
> +	int tree_id;
> +
> +	work->tcon = NULL;
> +	if (work->conn->ops->get_cmd_val(work) == SMB2_TREE_CONNECT_HE ||
> +	    work->conn->ops->get_cmd_val(work) ==  SMB2_CANCEL_HE ||
> +	    work->conn->ops->get_cmd_val(work) ==  SMB2_LOGOFF_HE) {
> +		ksmbd_debug(SMB, "skip to check tree connect request\n");
> +		return 0;
> +	}
> +
> +	if (xa_empty(&work->sess->tree_conns)) {
> +		ksmbd_debug(SMB, "NO tree connected\n");
> +		return -1;

Better to return -EINVAL.

> +	}
> +
> +	tree_id = le32_to_cpu(req_hdr->Id.SyncId.TreeId);
> +	work->tcon = ksmbd_tree_conn_lookup(work->sess, tree_id);
> +	if (!work->tcon) {
> +		pr_err("Invalid tid %d\n", tree_id);
> +		return -1;
> +	}
> +
> +	return 1;
> +}

regards,
dan carpenter
