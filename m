Return-Path: <linux-fsdevel+bounces-35007-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4026E9CFCF6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Nov 2024 08:22:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B90881F247A4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Nov 2024 07:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4458719149F;
	Sat, 16 Nov 2024 07:22:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93327A47;
	Sat, 16 Nov 2024 07:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731741741; cv=none; b=aa9ZY7A9nDEv+s0FloLw2M92+rm2bRprpE8i9IF+19XoHVC+mP+uG994RGG80kiNbl/LHh6rFczIwyeACyanDK+pmfo3m0IRTcsLdAw44KSFJND2gbjNoDYBO6BXT43ooH9D7zSZZgG7qDoyEF5diXgswEIyFPzU0iERJ/HR3bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731741741; c=relaxed/simple;
	bh=TUzNswKRL/IH64Yt47bVlyeUuJVYgO2Zohn3HdlFeOM=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=jnIqX5BN3I2dRb9Ri8XBOhyjcVTVfVWAGa1hwOYtQSH0PHf3qxj3VEviPM/6kyAflA+tQB3HmDTgQOBt8R+sbmfxTeGETQrzte23QZYs9ffrnYoFH6YO6wRvs+aPNf8jtPULh3cdNlBu+nM0JYcIx/81VFfIiWQvqKZRcH4Ue5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Xr51H49T3z4f3lDh;
	Sat, 16 Nov 2024 15:21:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id CA7F41A018D;
	Sat, 16 Nov 2024 15:22:14 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP4 (Coremail) with SMTP id gCh0CgDHo4chSDhnaj65Bw--.56175S3;
	Sat, 16 Nov 2024 15:22:11 +0800 (CST)
Subject: Re: [RFC PATCH 6/6 6.6] libfs: fix infinite directory reads for
 offset dir
To: Chuck Lever <chuck.lever@oracle.com>,
 yangerkun <yangerkun@huaweicloud.com>
Cc: Yu Kuai <yukuai1@huaweicloud.com>, Chuck Lever <cel@kernel.org>,
 linux-stable <stable@vger.kernel.org>,
 "harry.wentland@amd.com" <harry.wentland@amd.com>,
 "sunpeng.li@amd.com" <sunpeng.li@amd.com>,
 "Rodrigo.Siqueira@amd.com" <Rodrigo.Siqueira@amd.com>,
 "alexander.deucher@amd.com" <alexander.deucher@amd.com>,
 "christian.koenig@amd.com" <christian.koenig@amd.com>,
 "Xinhui.Pan@amd.com" <Xinhui.Pan@amd.com>,
 "airlied@gmail.com" <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Liam Howlett <liam.howlett@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Greg KH <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>,
 "srinivasan.shanmugam@amd.com" <srinivasan.shanmugam@amd.com>,
 "chiahsuan.chung@amd.com" <chiahsuan.chung@amd.com>,
 "mingo@kernel.org" <mingo@kernel.org>,
 "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
 "chengming.zhou@linux.dev" <chengming.zhou@linux.dev>,
 "zhangpeng.00@bytedance.com" <zhangpeng.00@bytedance.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>,
 "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
 linux-mm <linux-mm@kvack.org>, "yi.zhang@huawei.com" <yi.zhang@huawei.com>,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20241111005242.34654-1-cel@kernel.org>
 <20241111005242.34654-7-cel@kernel.org>
 <278433c2-611c-6c8e-7964-5c11977b68b7@huaweicloud.com>
 <96A93064-8DCE-4B78-9F2A-CF6E7EEABEB1@oracle.com>
 <73a05cb9-569c-9b3c-3359-824e76b14461@huaweicloud.com>
 <ZzTDE+RN5d/mwUXl@tissot.1015granger.net>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <5d0b46ee-ff09-f0ac-1920-6736394245ca@huaweicloud.com>
Date: Sat, 16 Nov 2024 15:22:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZzTDE+RN5d/mwUXl@tissot.1015granger.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDHo4chSDhnaj65Bw--.56175S3
X-Coremail-Antispam: 1UD129KBjvJXoW3XryfJF43ury3Gw4kGw1xKrg_yoWxArW7pa
	y5GFWDKr4kJr1UCFsFkw1jyayI9343Jr17urn5Jw18Aas8Wr9xGF1xCr1YgFy7uF4qgr4a
	va18XFZxXr4jqaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26rWY6Fy7MxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWrXVW8Jr1lIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pR1lkxUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/11/13 23:17, Chuck Lever 写道:
> On Mon, Nov 11, 2024 at 11:20:17PM +0800, yangerkun wrote:
>>
>>
>> 在 2024/11/11 22:39, Chuck Lever III 写道:
>>>
>>>
>>>> On Nov 10, 2024, at 9:36 PM, Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>>> I'm in the cc list ,so I assume you saw my set, then I don't know why
>>>> you're ignoring my concerns.
>>>> 1) next_offset is 32-bit and can overflow in a long-time running
>>>> machine.
>>>> 2) Once next_offset overflows, readdir will skip the files that offset
>>>> is bigger.
>>
>> I'm sorry, I'm a little busy these days, so I haven't responded to this
>> series of emails.
>>
>>> In that case, that entry won't be visible via getdents(3)
>>> until the directory is re-opened or the process does an
>>> lseek(fd, 0, SEEK_SET).
>>
>> Yes.
>>
>>>
>>> That is the proper and expected behavior. I suspect you
>>> will see exactly that behavior with ext4 and 32-bit
>>> directory offsets, for example.
>>
>> Emm...
>>
>> For this case like this:
>>
>> 1. mkdir /tmp/dir and touch /tmp/dir/file1 /tmp/dir/file2
>> 2. open /tmp/dir with fd1
>> 3. readdir and get /tmp/dir/file1
>> 4. rm /tmp/dir/file2
>> 5. touch /tmp/dir/file2
>> 4. loop 4~5 for 2^32 times
>> 5. readdir /tmp/dir with fd1
>>
>> For tmpfs now, we may see no /tmp/dir/file2, since the offset has been
>> overflow, for ext4 it is ok... So we think this will be a problem.
> 
> I constructed a simple test program using the above steps:
> 
> /*
>   * 1. mkdir /tmp/dir and touch /tmp/dir/file1 /tmp/dir/file2
>   * 2. open /tmp/dir with fd1
>   * 3. readdir and get /tmp/dir/file1
>   * 4. rm /tmp/dir/file2
>   * 5. touch /tmp/dir/file2
>   * 6. loop 4~5 for 2^32 times
>   * 7. readdir /tmp/dir with fd1
>   */
> 
> #include <sys/types.h>
> #include <sys/stat.h>
> 
> #include <dirent.h>
> #include <errno.h>
> #include <fcntl.h>
> #include <unistd.h>
> #include <stdbool.h>
> #include <stdio.h>
> #include <string.h>
> 
> static void list_directory(DIR *dirp)
> {
> 	struct dirent *de;
> 
> 	errno = 0;
> 	do {
> 		de = readdir(dirp);
> 		if (!de)
> 			break;
> 
> 		printf("d_off:  %lld\n", de->d_off);
> 		printf("d_name: %s\n", de->d_name);
> 	} while (true);
> 
> 	if (errno)
> 		perror("readdir");
> 	else
> 		printf("EOD\n");
> }
> 
> int main(int argc, char **argv)
> {
> 	unsigned long i;
> 	DIR *dirp;
> 	int ret;
> 
> 	/* 1. */
> 	ret = mkdir("/tmp/dir", 0755);
> 	if (ret < 0) {
> 		perror("mkdir");
> 		return 1;
> 	}
> 
> 	ret = creat("/tmp/dir/file1", 0644);
> 	if (ret < 0) {
> 		perror("creat");
> 		return 1;
> 	}
> 	close(ret);
> 
> 	ret = creat("/tmp/dir/file2", 0644);
> 	if (ret < 0) {
> 		perror("creat");
> 		return 1;
> 	}
> 	close(ret);
> 
> 	/* 2. */
> 	errno = 0;
> 	dirp = opendir("/tmp/dir");
> 	if (!dirp) {
> 		if (errno)
> 			perror("opendir");
> 		else
> 			fprintf(stderr, "EOD\n");
> 		closedir(dirp);
> 		return 1;
> 	}
> 
> 	/* 3. */
> 	errno = 0;
> 	do {
> 		struct dirent *de;
> 
> 		de = readdir(dirp);
> 		if (!de) {
> 			if (errno) {
> 				perror("readdir");
> 				closedir(dirp);
> 				return 1;
> 			}
> 			break;
> 		}
> 		if (strcmp(de->d_name, "file1") == 0) {
> 			printf("Found 'file1'\n");
> 			break;
> 		}
> 	} while (true);
> 
> 	/* run the test. */
> 	for (i = 0; i < 10000; i++) {
> 		/* 4. */
> 		ret = unlink("/tmp/dir/file2");
> 		if (ret < 0) {
> 			perror("unlink");
> 			closedir(dirp);
> 			return 1;
> 		}
> 
> 		/* 5. */
> 		ret = creat("/tmp/dir/file2", 0644);
> 		if (ret < 0) {
> 			perror("creat");
> 			fprintf(stderr, "i = %lu\n", i);
> 			closedir(dirp);
> 			return 1;
> 		}
> 		close(ret);
> 	}
> 
> 	/* 7. */
> 	printf("\ndirectory after test:\n");
> 	list_directory(dirp);
> 
> 	/* cel. */
> 	rewinddir(dirp);
> 	printf("\ndirectory after rewind:\n");
> 	list_directory(dirp);
> 
> 	closedir(dirp);
> 	return 0;
> }
> 
> 
>>> Does that not directly address your concern? Or do you
>>> mean that Erkun's patch introduces a new issue?
>>
>> Yes, to be honest, my personal feeling is a problem. But for 64bit, it may
>> never been trigger.
> 
> I ran the test program above on this kernel:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/log/?h=nfsd-testing
> 
> Note that it has a patch to restrict the range of directory offset
> values for tmpfs to 2..4096.
> 
> I did not observe any unexpected behavior after the offset values
> wrapped. At step 7, I can always see file2, and its offset is always
> 4. At step "cel" I can see all expected directory entries.

Then, do you investigate more or not?
> 
> I tested on v6.12-rc7 with the same range restriction but using
> Maple tree and 64-bit offsets. No unexpected behavior there either.
> 
> So either we're still missing something, or there is no problem. My
> only theory is maybe it's an issue with an implicit integer sign
> conversion, and we should restrict the offset range to 2..S32_MAX.
> 
> I can try testing with a range of (U32_MAX - 4096)..(U32_MAX).

You can try the following reproducer, it's much simpler. First, apply
following patch(on latest kernel):

diff --git a/fs/libfs.c b/fs/libfs.c
index a168ece5cc61..7c1a5982a0c8 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -291,7 +291,7 @@ int simple_offset_add(struct offset_ctx *octx, 
struct dentry *dentry)
                 return -EBUSY;

         ret = mtree_alloc_cyclic(&octx->mt, &offset, dentry, 
DIR_OFFSET_MIN,
-                                LONG_MAX, &octx->next_offset, GFP_KERNEL);
+                                256, &octx->next_offset, GFP_KERNEL);
         if (ret < 0)
                 return ret;


Then, create a new tmpfs dir, inside the dir:

[root@fedora test-libfs]# for ((i=0; i<256; ++i)); do touch $i; done
touch: cannot touch '255': Device or resource busy
[root@fedora test-libfs]# ls
0    103  109  114  12   125  130  136  141  147  152  158  163  169 
174  18   185  190  196  200  206  211  217  222  228  233  239  244  25 
   26  31  37  42  48  53  59  64  7   75  80  86  91  97
1    104  11   115  120  126  131  137  142  148  153  159  164  17 
175  180  186  191  197  201  207  212  218  223  229  234  24   245 
250  27  32  38  43  49  54  6   65  70  76  81  87  92  98
10   105  110  116  121  127  132  138  143  149  154  16   165  170 
176  181  187  192  198  202  208  213  219  224  23   235  240  246 
251  28  33  39  44  5   55  60  66  71  77  82  88  93  99
100  106  111  117  122  128  133  139  144  15   155  160  166  171 
177  182  188  193  199  203  209  214  22   225  230  236  241  247 
252  29  34  4   45  50  56  61  67  72  78  83  89  94
101  107  112  118  123  129  134  14   145  150  156  161  167  172 
178  183  189  194  2    204  21   215  220  226  231  237  242  248 
253  3   35  40  46  51  57  62  68  73  79  84  9   95
102  108  113  119  124  13   135  140  146  151  157  162  168  173 
179  184  19   195  20   205  210  216  221  227  232  238  243  249 
254  30  36  41  47  52  58  63  69  74  8   85  90  96
[root@fedora test-libfs]# rm -f 0
[root@fedora test-libfs]# touch 255
[root@fedora test-libfs]# ls
255
[root@fedora test-libfs]#

I don't think I have to explain why the second ls can only show the file
255...

Thanks,
Kuai

> 
> 
>>> If there is a problem here, please construct a reproducer
>>> against this patch set and post it.
> 
> Invitation still stands: if you have a solid reproducer, please post
> it.
> 
> 


