Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFCC1E6D0A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 May 2020 23:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407472AbgE1VB6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 17:01:58 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:53682 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407471AbgE1VBq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 17:01:46 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04SKBfKY120264;
        Thu, 28 May 2020 21:01:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=6o6IG4PaUZVYP05KoABvyzMEsMWMZIDBFpnDQktXQQg=;
 b=Nq8f2RZF+94ho8W4EH/YHSsyAfGdzMRljWNJycQ6LyaIhRsqlCLtPQ+W+ZipiaNwu8lf
 Kto1R7tGS+X7Rb7nMzY43E8y6Ci2viK0F3NjfWxSi5/rbu8fhGgcjSoDoj7RD8Hitdjm
 npnhplBqCoC6e/2fauxyzA9kSRIMGwi/ky+mzm9lAJdmeEYXdZb9qJwT89CZ3wlb4Lxs
 iUlFvJQ/bBmNk7d9MX80KPLi5ufNC05dFho9+jr+KMmfLAKPljRTkmuyt7Y1fg5ylVTK
 +QWuqMq77gINHfJL70aahnX2RUe1H1OG7dFjC7GKx/rRv16w5Zsqqoht5ns5juh4ASkc TA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 316u8r792v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 28 May 2020 21:01:31 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04SK8w9n177071;
        Thu, 28 May 2020 21:01:31 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 317ds38qex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 May 2020 21:01:30 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04SL1Rwl012580;
        Thu, 28 May 2020 21:01:28 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 28 May 2020 14:01:27 -0700
Subject: Re: [PATCH v2] ovl: provide real_file() and overlayfs
 get_unmapped_area()
To:     kbuild test robot <lkp@intel.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     kbuild-all@lists.01.org, Colin Walters <walters@verbum.org>,
        syzbot <syzbot+d6ec23007e951dadf3de@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-unionfs@vger.kernel.org
References: <4ebd0429-f715-d523-4c09-43fa2c3bc338@oracle.com>
 <202005281652.QNakLkW3%lkp@intel.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <365d83b8-3af7-2113-3a20-2aed51d9de91@oracle.com>
Date:   Thu, 28 May 2020 14:01:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <202005281652.QNakLkW3%lkp@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9635 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005280132
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9635 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 priorityscore=1501 spamscore=0 cotscore=-2147483648 suspectscore=0
 phishscore=0 clxscore=1011 mlxlogscore=999 bulkscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005280132
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/28/20 1:37 AM, kbuild test robot wrote:
> Hi Mike,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on miklos-vfs/overlayfs-next]
> [also build test ERROR on linus/master v5.7-rc7]
> [cannot apply to linux/master next-20200526]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> 
> url:    https://github.com/0day-ci/linux/commits/Mike-Kravetz/ovl-provide-real_file-and-overlayfs-get_unmapped_area/20200528-080533
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git overlayfs-next
> config: h8300-randconfig-r036-20200528 (attached as .config)
> compiler: h8300-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=h8300 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All error/warnings (new ones prefixed by >>, old ones prefixed by <<):
> 
> fs/overlayfs/file.c: In function 'ovl_get_unmapped_area':
>>> fs/overlayfs/file.c:768:14: error: 'struct mm_struct' has no member named 'get_unmapped_area'
> 768 |   current->mm->get_unmapped_area)(realfile,
> |              ^~
>>> fs/overlayfs/file.c:770:1: warning: control reaches end of non-void function [-Wreturn-type]
> 770 | }
> | ^
> 
> vim +768 fs/overlayfs/file.c
> 
>    760	
>    761	static unsigned long ovl_get_unmapped_area(struct file *file,
>    762					unsigned long uaddr, unsigned long len,
>    763					unsigned long pgoff, unsigned long flags)
>    764	{
>    765		struct file *realfile = real_file(file);
>    766	
>    767		return (realfile->f_op->get_unmapped_area ?:
>  > 768			current->mm->get_unmapped_area)(realfile,
>    769							uaddr, len, pgoff, flags);
>  > 770	}
>    771	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 

Well yuck!  get_unmapped_area is not part of mm_struct if !CONFIG_MMU.

Miklos, would adding '#ifdef CONFIG_MMU' around the overlayfs code be too
ugly for you?  Another option is to use real_file() in the mmap code as
done in [1].

Sorry for all the questions.  However, I want to make sure you are happy
with any overlayfs changes.

[1] https://lore.kernel.org/linux-mm/04a00e3b-539c-236f-e43b-0024ef94b7cb@oracle.com/
-- 
Mike Kravetz
