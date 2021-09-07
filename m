Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF4DC40306E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Sep 2021 23:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347288AbhIGVpA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Sep 2021 17:45:00 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:36544 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234307AbhIGVo7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Sep 2021 17:44:59 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 187LTuop025789;
        Tue, 7 Sep 2021 21:43:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2021-07-09;
 bh=AgDEBIyDjjx+63d7RZguo/UwWyqrH4hZpKf1UZ2Y3lU=;
 b=SOhXtdA18aXY+HfbzETerBzA5898GgYV2O8pwidIoFfHBk3f9xyepQwlkMrU4RB1m/rw
 HrJnCiAdoM8HeU8+uUVqqIUmbIuWQTHNVnrNf9Kvti8qsWUaIxPZsrwmZ5Hk4SC27hd2
 wOk4KKOEpjagBWajfmCmCsDVCp8a0XBevuKizEL2CxU4OvXb0ZnlfQbMNORZfTsYu7Up
 Ce6uu8Xjk7s+XqON2oWgfBXhzSCcdUGPdGks1jS15ArKjG4rR/P36KlbxS7/PVO+6x3z
 AKkOHCnB0ax5vxPUHSO19fhP1ltK+E644s48jy+sF/L8wRoLcrAznf0jb2UkPxevSwN1 jQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2020-01-29;
 bh=AgDEBIyDjjx+63d7RZguo/UwWyqrH4hZpKf1UZ2Y3lU=;
 b=sVGdg6pWYUxaOiHn8T8cN7SoDoU37Uj2j7Nv736aA6FdoO4nhzX77Q7rD0jQD3Z11tdz
 kMpH0OE1QixE22L0UTI2+deHWuWfarLmdxMGgb55Xa9E7ktPzM9AYUAECiR4aNHqAOWj
 0lL870XZuAfhHSwnSRVnfMlD6fpaEAZMVvrfZ5syM+H5yl3ZN2J+rF9CoEW2DUGNcsA/
 nKrsxuG/QgDTPKS1uCl4eORw6c68YA2qZiG47j6E/AJ3BEi0kin0jJjL+npNTVWCEKQ0
 RirojZrLjXj1fVUwRHpwMCmLjVWG3UcN/WnWw15F4/4+ea7Lv9QKVl/EEGn5xK1iWW4J cw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3axd8q0gpr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Sep 2021 21:43:52 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 187Le2Dw022832;
        Tue, 7 Sep 2021 21:43:51 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by aserp3020.oracle.com with ESMTP id 3axcpk9saf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Sep 2021 21:43:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NtUBbqpXxTAUq4BStHB6onPagTjXJt3tYHiTqe1iWxaMSw2hIGJ8J+0HYYWVkuYPScti6PLkBGABpZryYm79lNNH64j7wVjV6C7XzSGm2XSEIvfj+Bc4qOxUsAlvptOhZxjdKpVEpohJSgNQwIZSrdIqPjXRRfRb/KCJiHh0K5NHTxAY19yMuiECAaGbfH8J1ubu0S1zwQqcSHPMMYTsLIzT+IbITWknmdwqN4fqtdVcXK6Xy6VK+J9gOvZsaMmE901lH843cXeii9J5vBTjdDV5Of29M7taATjR/Kl7njnP+hZl+vMlhJwwOPiNT+QNA17ebU98vWM9cEtiuj9MoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=AgDEBIyDjjx+63d7RZguo/UwWyqrH4hZpKf1UZ2Y3lU=;
 b=FsS/c5s4S75hm3sYooTAlX2LWI1C1CrjFMbzKzZvgipQJMwkg9aGec57Eg/tO8DzaJgvqgUUn4e8Kpksc0ogytIH8fVIk6skw2+GV5E6kt8jpKyMAjAau6rtIuw/U/v+m7IbNuhsn+qQ+pGP/YLsYxyZPKaq+mwb1rfStV2z9Hjll2lcgJS6l8NQlXxdmOQYCxefVM0zK9tB6FGW/cnNHEkcyUfEp8FF+4c6nJR3PVzNnlgOk6+NXT2P4adB5q6U2plF2aVz0sD+F18vWmqpXSw+AFsVRPC9qF6F+4Zp+bhr7YL/tDnO67PbB2O24huFzg+SaxLVldjCusY07dTp9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AgDEBIyDjjx+63d7RZguo/UwWyqrH4hZpKf1UZ2Y3lU=;
 b=HZ9+gtOsVy++7J9TNCqNfSbBdoIZjBCsnRmUg4djBcJtfEpxvUWUqdd+/zBPD6jpKml2vedFYc0hv8dVQT8G9PvouIKYynBE9hNV4NwOOviGP+c0ABUfNF9IZ16nbP0ERyQ/4nyXNGdRXUdd9JbU5JRhKlc9x7aJvTzd3qPlD2M=
Authentication-Results: zeniv.linux.org.uk; dkim=none (message not signed)
 header.d=none;zeniv.linux.org.uk; dmarc=none action=none
 header.from=oracle.com;
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by CH0PR10MB4908.namprd10.prod.outlook.com (2603:10b6:610:cb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17; Tue, 7 Sep
 2021 21:43:49 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::2c22:7eb8:a2f0:e027]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::2c22:7eb8:a2f0:e027%9]) with mapi id 15.20.4478.025; Tue, 7 Sep 2021
 21:43:49 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] namei: fix use-after-free and adjust calling
 conventions
In-Reply-To: <YTfVE7IbbTV71Own@zeniv-ca.linux.org.uk>
References: <20210901175144.121048-1-stephen.s.brennan@oracle.com>
 <YTfVE7IbbTV71Own@zeniv-ca.linux.org.uk>
Date:   Tue, 07 Sep 2021 14:43:48 -0700
Message-ID: <87tuiwrrhn.fsf@stepbren-lnx.us.oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0105.namprd11.prod.outlook.com
 (2603:10b6:806:d1::20) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
Received: from localhost (148.87.23.7) by SA0PR11CA0105.namprd11.prod.outlook.com (2603:10b6:806:d1::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.20 via Frontend Transport; Tue, 7 Sep 2021 21:43:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37d22517-8e97-458b-f6ab-08d9724893f0
X-MS-TrafficTypeDiagnostic: CH0PR10MB4908:
X-Microsoft-Antispam-PRVS: <CH0PR10MB4908242636BE02DF627030FDDBD39@CH0PR10MB4908.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6EeKCxsTUDzVjmKuySeSCTEDwUdBDY4xhHcplAaHhg3rVnTOuFgcMGvZA7VEm2GpH40V2DwNKlmND/pyclmhhab2sKomixl9AJwADZZuyJ2eifGsVEEH51NovdWnE80HZxglzFBS97rNejUPPWz7VSIGxbyk2YYqj7PeZKtz0ntH7M5PepZfkJZMWESD3G82691FDlzXjv4FQ3yfKmKCkEEJ6Leb2F3ky1+pkmC4x4PVZecNvl1WOlF3xBQBytAbagN9zSr18QVJfXs22QZ2egdmHUaMtFEDsOIHuEgvcxPIfj6vQl4afWpFy81mVST32UIe1golaBFR6VD8RZ4mNrLdLRFEkz5pLCeT5vxYN/CL+H5WRVkrwIsTOSt8oG7wS/AAS23cz/V/+LdWMxh9iSf0m4zmBULmnQCEUhMlRUUr/k/NagLX7F6ez0tyiYFQN4rxpIfirHYog5sV0WYkLBC9sriilCdP5b0NGcB2mbgwPck6piL2+Na2MHv40zts60eVHeFUPbyDj6W6l63xjAKrzh5o4hFZQf68+XPlLAlRkgDCtFlvJk7BTuS8k+qmmq7fWaDVfX1V97+dAPf0hh+mbtU9O0VVoEkK7I3qL05MLGINosDGHOAC3vAh6plGKJ3NibfZ/jBJAWTsHCGMqD/dYAarP1kkysXzNMh63Qnr3pxCi/1dr32C6C1xTDA+udCsm4nQxiZYlcWzaJr0T0lrIp0jUshuBqCPVcDk0YAKiPgZaQUEOg8cC23sik9qyUEECbB/XnHk8dkanNt40A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(366004)(396003)(136003)(39860400002)(26005)(66556008)(186003)(6916009)(66946007)(2906002)(66476007)(6486002)(956004)(83380400001)(966005)(478600001)(8936002)(4326008)(316002)(5660300002)(8676002)(52116002)(86362001)(38100700002)(38350700002)(6496006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H83BeF2Z6lf25z+aiHSQN6xd3sLGuPt8dBA3zjpEdeId2zxcMwXv5mzVrz5B?=
 =?us-ascii?Q?K12sshN81ZLsJ3V5yseDsoccJ9vUaniIxKsA1C3EsMA581P8Bv6vlDtwQTaN?=
 =?us-ascii?Q?aQguBgI2+KyzoDqV3CpJuuAMvNZHB1XX9/kiuGkdqFOKDu44s1b9kXV1B6AY?=
 =?us-ascii?Q?/il6VBJFsH6caeo5OOvMwZIRa1WJWH99Q75pwxUsX0i9b2FTGdkqaBWrQ07e?=
 =?us-ascii?Q?deIGdWLQ8yoLQATq+6QDkAyLYssM0v3PjdqZMnzXorl/w8/0QDGYSGkmJ8a7?=
 =?us-ascii?Q?/+62ZoAmgcsuR408rr56e+SlapE7/waUAxU8rls6X5lpG08UquP/D5ogrRZF?=
 =?us-ascii?Q?zYEV7Dt/o2gEN22rPIZE8VMBFujoCsihbUKFwNnlxIfgps5K3yXOMZryCfbX?=
 =?us-ascii?Q?9IUBCiCdmhgCFUAohCp/in+AqZGV40Q/feDz2cQbrYXwAhpRpfh/VOGhboaQ?=
 =?us-ascii?Q?/0f4Kr0I1mnIHzFuliXXarEhG6tW+mfFFutdvAOaUbILgeb84pyp2p7HJZ1J?=
 =?us-ascii?Q?jZCLOQ8mzuiMAyQqMpyTP7cMr/9aZVWxrfzGi80Qwv6464qmHOiqRfZwVK/d?=
 =?us-ascii?Q?u80NSk/FPTN4egTDe43MjikzYcAAsHKL448Qp5syQTTI4MnrVdZ+hRi9E5RU?=
 =?us-ascii?Q?npvEwdhUS7MVIhzMwcQLt31FgkrxSZ3w62QibVtlMqp5ahM5uk5iEJMn+dwb?=
 =?us-ascii?Q?rAtWEuE3X7BJqKxTWx4wyyfeCADJOumnnBXKy45F8P2QXnTOfXSR9MSCKAf3?=
 =?us-ascii?Q?F6fObGH9q3fDBpQchnrs3DI3kqJtJTuzigoUIGBPvfcKtKE7zmyGmpphpD0m?=
 =?us-ascii?Q?pcbvyleBSdbw9g7Xvh8NQ+4PwrvKEAZdWz98ZRNesfkPFcboWqhfxaOhhBIf?=
 =?us-ascii?Q?7z8aSAk34YFzL46/a+6jlU7M1NQvRAKO1VSSqkmGsJhizl/pIOZyyqiBDLBv?=
 =?us-ascii?Q?Tq4wknOefURWtHNbcSkleGHaBa3FEM91zdP7WgguV8a9U54xNHCBNvwOd0Kw?=
 =?us-ascii?Q?2xyqCpBFLWw4P4uffptkl+E8xIxzFLqx9xQYTFg/ZJ2e0cfJYC8sy/yKaCwY?=
 =?us-ascii?Q?VMrLHqe1L8pUIQt8KS1uBi4wD1eQdGlRIVebNqTnSJtwZisVugnoRd6pfZYf?=
 =?us-ascii?Q?rwdHlqL26M5xTCcKoTH90zf+zVSJ3ZMtBzGtOUCFRa4QqrojeXHxPKPAetGv?=
 =?us-ascii?Q?YmrzhLe5HEMMNnDEUw3rLSULoBYyIkEZCl22GUjEjbmwgEXyGDP5zWTjhiLc?=
 =?us-ascii?Q?9nNo3wgSmJMy/jnOG1p48dlx3qMcHnYUQYz2tStkoLYhh/W15Kw/68aOCQxe?=
 =?us-ascii?Q?4pyE7bmZisUzwcr3gIcoUVos?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37d22517-8e97-458b-f6ab-08d9724893f0
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2021 21:43:49.6040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CYdvkRGl4/+ww7KeP9/peN1hrMPaOVbjHgRKuJAWo+QB7AT78Hc9JrGVyHRoMQgTzdizCwfQD7wTja0k54fnsTK7vXnuTmeaOc0wS9ZRmu4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4908
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10100 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109070136
X-Proofpoint-GUID: O78bjq5un3PFko3HvcTy67UAeeeJrRwE
X-Proofpoint-ORIG-GUID: O78bjq5un3PFko3HvcTy67UAeeeJrRwE
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Al Viro <viro@zeniv.linux.org.uk> writes:
> On Wed, Sep 01, 2021 at 10:51:40AM -0700, Stephen Brennan wrote:
>> Drawing from the comments on the last two patches from me and Dmitry,
>> the concensus is that __filename_parentat() is inherently buggy, and
>> should be removed. But there's some nice consistency to the way that
>> the other functions (filename_create, filename_lookup) are named which
>> would get broken.
>> 
>> I looked at the callers of filename_create and filename_lookup. All are
>> small functions which are trivial to modify to include a putname(). It
>> seems to me that adding a few more lines to these functions is a good
>> traedoff for better clarity on lifetimes (as it's uncommon for functions
>> to drop references to their parameters) and better consistency.
>> 
>> This small series combines the UAF fix from me, and the removal of
>> __filename_parentat() from Dmitry as patch 1. Then I standardize
>> filename_create() and filename_lookup() and their callers.
>
> 	For kern_path_locked() itself, I'd probably go for
>
> static struct dentry *__kern_path_locked(struct filename *name, struct path *path)
> {
>         struct dentry *d;
>         struct qstr last;
>         int type, error;
>
>         error = filename_parentat(AT_FDCWD, name, 0, path,
>                                     &last, &type);
>         if (error)
>                 return ERR_PTR(error);
>         if (unlikely(type != LAST_NORM)) {
>                 path_put(path);
>                 return ERR_PTR(-EINVAL);
>         }
>         inode_lock_nested(path->dentry->d_inode, I_MUTEX_PARENT);
>         d = __lookup_hash(&last, path->dentry, 0);
>         if (IS_ERR(d)) {
>                 inode_unlock(path->dentry->d_inode);
>                 path_put(path);
>         }
>         return d;
> }
>
> static struct dentry *kern_path_locked(const char *name, struct path *path)
> {
> 	struct filename *filename = getname_kernel(name);
> 	struct dentry *res = __kern_path_locked(filename, path);
>
> 	putname(filename);
> 	return res;
> }
>
> instead of that messing with gotos - and split renaming from fix in that
> commit.  In 3/3 you have a leak; trivial to fix, fortunately.

Got it. My v2 crossed paths with your message here, it only fixes the
leak but not the kern_path_locked() change and split. Please ignore it
and I'll adjust patch 1 for v3.

>
> Another part I really dislike in that area (not your fault, obviously)
> is
>
> void putname(struct filename *name)
> {
>         if (IS_ERR_OR_NULL(name))
> 		return;
>
> in mainline right now.  Could somebody explain when the hell has NULL
> become a possibility here?  OK, I buy putname(ERR_PTR(...)) being
> a no-op, but IME every sodding time we mixed NULL and ERR_PTR() in
> an API we ended up with headache later.

From the links in the blame it seems this was suggested by Linus
here[1].  The core frustration having been with the state of
__filename_create() and friends freeing filenames at different times
depending on whether an error occurred.

[1] https://lore.kernel.org/io-uring/CAHk-=wgCac9hBsYzKMpHk0EbLgQaXR=OUAjHaBtaY+G8A9KhFg@mail.gmail.com/

Thanks,
Stephen

> 	IS_ERR_OR_NULL() is almost always wrong.  NULL as argument
> for destructor makes sense when constructor can fail with NULL;
> not the case here.
>
> 	How about the variant in vfs.git#misc.namei?
